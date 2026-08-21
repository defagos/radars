/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
`AssetPersistenceManager` is the main class in this sample that demonstrates how to
 manage downloading HLS streams. It includes APIs for starting and canceling downloads,
 deleting existing assets from a person's device, and monitoring the download progress.
*/

import Foundation
import AVFoundation
import os

private let logger = Logger(subsystem: "com.example.apple-samplecode.HLSCatalog", category: "AssetPersistenceManager")

/// - Tag: AssetPersistenceManager
class AssetPersistenceManager: NSObject {
    // MARK: Properties

    /// Singleton for `AssetPersistenceManager`.
    static let sharedManager = AssetPersistenceManager()

    /// Internal Boolean, used to track if `AssetPersistenceManager` finished restoring its state.
    private var didRestorePersistenceManager = false

    /// The `AVAssetDownloadURLSession` to use for managing `AVAssetDownloadTasks`.
    fileprivate var assetDownloadURLSession: AVAssetDownloadURLSession!

    /// Internal map of `AVAssetDownloadTask` to its corresponding Asset.
    fileprivate var activeDownloadsMap = [AVAssetDownloadTask: Asset]()

    /// Internal map of `AVAssetDownloadTask` to download URL.
    fileprivate var willDownloadToUrlMap = [AVAssetDownloadTask: URL]()
    
    /// Internal list of `NSKeyValueObservation` per `AVAssetDownloadTask` to track download progress.
    fileprivate var progressObservers: [NSKeyValueObservation] = []

    // MARK: Intialization

    override private init() {

        super.init()

        /// Create the configuration for the `AVAssetDownloadURLSession`.
        let backgroundConfiguration = URLSessionConfiguration.background(withIdentifier: "AAPL-Identifier")

        /// Create the `AVAssetDownloadURLSession` using the configuration.
        assetDownloadURLSession =
            AVAssetDownloadURLSession(configuration: backgroundConfiguration,
                                      assetDownloadDelegate: self, delegateQueue: OperationQueue.main)
    }
    
    /// Restores the application state by getting all instances of `AVAssetDownloadTask` and restoring their `Asset` structures.
    func restorePersistenceManager() {
        guard !didRestorePersistenceManager else { return }
        
        didRestorePersistenceManager = true
        
        /// Grab all the tasks associated with the `assetDownloadURLSession`.
        assetDownloadURLSession.getAllTasks { tasksArray in
            /// For each task, restore the state in the app by recreating `Asset` structures and reusing existing `AVURLAsset` objects.
            for task in tasksArray {
                guard let assetDownloadTask = task as? AVAssetDownloadTask, let assetName = task.taskDescription else { break }
                
                let stream = StreamListManager.shared.stream(withName: assetName)
                
                let urlAsset = assetDownloadTask.urlAsset
                
                let asset = Asset(stream: stream, urlAsset: urlAsset)
                
                self.activeDownloadsMap[assetDownloadTask] = asset
            }
            
            NotificationCenter.default.post(name: .AssetPersistenceManagerDidRestoreState, object: nil)
        }
    }

    /// Triggers the initial `AVAssetDownloadTask` for a given Asset.
    /// - Tag: DownloadStream
    func downloadStream(for asset: Asset) async throws {

        // Get the default media selections for the asset's media selection groups.
        let preferredMediaSelection = try await asset.urlAsset.load(.preferredMediaSelection)

        /*
         Creates and initializes an `AVAssetDownloadTask` using an `AVAssetDownloadConfiguration` to download multiple `AVMediaSelections`
         on an `AVURLAsset`.
         The `primaryContentConfiguration` in `AVAssetDownloadConfiguration` requests for a variant with bitrate greater than one of the
         lower bitrate variants in the asset.
         */
        let config = AVAssetDownloadConfiguration(asset: asset.urlAsset, title: asset.stream.name)
        /// Primary content configuration setup.
        let primaryQualifier = AVAssetVariantQualifier(predicate: NSPredicate(format: "peakBitRate < 1000000"))
        config.primaryContentConfiguration.variantQualifiers = [primaryQualifier]

        /// Download the German audio track only if available
        let mediaSelection = preferredMediaSelection.mutableCopy() as! AVMutableMediaSelection
        if let audibleGroup = try await asset.urlAsset.loadMediaSelectionGroup(for: .audible),
           let option = AVMediaSelectionGroup.mediaSelectionOptions(from: audibleGroup.options, filteredAndSortedAccordingToPreferredLanguages: ["de"]).first {
            mediaSelection.select(option, in: audibleGroup)
        }
        config.primaryContentConfiguration.mediaSelections = [mediaSelection]

        /// Creation of `AVAssetDownloadTask` with the above configured `AVAssetDownloadConfiguration`.
        let task = assetDownloadURLSession.makeAssetDownloadTask(downloadConfiguration: config)

        /// To better track the `AVAssetDownloadTask`, set the `taskDescription` to something unique for the sample.
        task.taskDescription = asset.stream.name

        activeDownloadsMap[task] = asset
        
        /// Use `task.progress` value to provide download progress updates in the UI.
        let progressObservation: NSKeyValueObservation = task.progress.observe(\.fractionCompleted) { progress, _ in
            Task { @MainActor in
                var userInfo = [String: Any]()
                userInfo[Asset.Keys.name] = asset.stream.name
                userInfo[Asset.Keys.percentDownloaded] = progress.fractionCompleted
                NotificationCenter.default.post(name: .AssetDownloadProgress, object: nil, userInfo: userInfo)
            }
        }
        self.progressObservers.append(progressObservation)

        task.resume()

        var userInfo = [String: Any]()
        userInfo[Asset.Keys.name] = asset.stream.name
        userInfo[Asset.Keys.downloadState] = Asset.DownloadState.downloading.rawValue
        userInfo[Asset.Keys.downloadSelectionDisplayName] = await displayNamesForSelectedMediaOptions(mediaSelection)

        NotificationCenter.default.post(name: .AssetDownloadStateChanged, object: nil, userInfo: userInfo)
    }

    /// Returns an Asset given a specific name if that Asset is associated with an active download.
    func assetForStream(withName name: String) -> Asset? {
        var asset: Asset?

        for (_, assetValue) in activeDownloadsMap where name == assetValue.stream.name {
            asset = assetValue
            break
        }

        return asset
    }
    
    /// Returns an Asset pointing to a file on disk if it exists.
    func localAssetForStream(withName name: String) -> Asset? {
        let userDefaults = UserDefaults.standard
        guard let localFileLocation = userDefaults.value(forKey: name) as? Data else { return nil }
        
        var asset: Asset?
        var bookmarkDataIsStale = false
        do {
            let url = try URL(resolvingBookmarkData: localFileLocation,
                                    bookmarkDataIsStale: &bookmarkDataIsStale)

            if bookmarkDataIsStale {
                fatalError("Bookmark data is stale!")
            }
            
            let urlAsset = AVURLAsset(url: url)
            let stream = StreamListManager.shared.stream(withName: name)
            
            asset = Asset(stream: stream, urlAsset: urlAsset)
            
            return asset
        } catch {
            fatalError("Failed to create URL from bookmark with error: \(error)")
        }
    }

    /// Returns the current download state for a given Asset.
    func downloadState(for asset: Asset) -> Asset.DownloadState {
        // Check if there is a file URL stored for this asset.
        if let localFileLocation = localAssetForStream(withName: asset.stream.name)?.urlAsset.url {
            // Check if the file exists on disk
            if FileManager.default.fileExists(atPath: localFileLocation.path) {
                return .downloaded
            }
        }

        // Check if there are any active downloads in flight.
        for (_, assetValue) in activeDownloadsMap where asset.stream.name == assetValue.stream.name {
            return .downloading
        }

        return .notDownloaded
    }

    /// Deletes an Asset on disk if possible.
    /// - Tag: RemoveDownload
    func deleteAsset(_ asset: Asset) {
        let userDefaults = UserDefaults.standard

        do {
            if let localFileLocation = localAssetForStream(withName: asset.stream.name)?.urlAsset.url {
                try FileManager.default.removeItem(at: localFileLocation)

                userDefaults.removeObject(forKey: asset.stream.name)

                var userInfo = [String: Any]()
                userInfo[Asset.Keys.name] = asset.stream.name
                userInfo[Asset.Keys.downloadState] = Asset.DownloadState.notDownloaded.rawValue

                NotificationCenter.default.post(name: .AssetDownloadStateChanged, object: nil,
                                                userInfo: userInfo)
            }
        } catch {
            logger.error("An error occured deleting the file: \(error)")
        }
    }

    /// Cancels an `AVAssetDownloadTask` given an `Asset`.
    /// - Tag: CancelDownload
    func cancelDownload(for asset: Asset) {
        var task: AVAssetDownloadTask?

        for (taskKey, assetVal) in activeDownloadsMap where asset == assetVal {
            task = taskKey
            break
        }

        task?.cancel()
    }
}

/// Return the display names for the media selection options that are currently selected in the specified group
func displayNamesForSelectedMediaOptions(_ mediaSelection: AVMediaSelection) async -> String {

    var displayNames = ""

    guard let asset = mediaSelection.asset else {
        return displayNames
    }

    guard let characteristics = try? await asset.load(.availableMediaCharacteristicsWithMediaSelectionOptions) else {
        return displayNames
    }
    
    // Iterate over every media characteristic in the asset in which a media selection option is available.
    for mediaCharacteristic in characteristics {
        /*
         Obtain the AVMediaSelectionGroup object that contains one or more options with the
         specified media characteristic, then get the media selection option that's currently
         selected in the specified group.
         */
        guard let mediaSelectionGroup = try? await asset.loadMediaSelectionGroup(for: mediaCharacteristic),
            let option = mediaSelection.selectedMediaOption(in: mediaSelectionGroup) else { continue }

        // Obtain the display string for the media selection option.
        if displayNames.isEmpty {
            displayNames += " " + option.displayName
        } else {
            displayNames += ", " + option.displayName
        }
    }

    return displayNames
}

/**
 Extend `AssetPersistenceManager` to conform to the `AVAssetDownloadDelegate` protocol.
 */
extension AssetPersistenceManager: AVAssetDownloadDelegate {

    /// Tells the delegate that the task finished transferring data.
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let userDefaults = UserDefaults.standard

        /*
         This is the ideal place to begin downloading additional media selections
         after the asset itself has finished downloading.
         */
        guard let task = task as? AVAssetDownloadTask,
            let asset = activeDownloadsMap.removeValue(forKey: task) else { return }

        guard let downloadURL = willDownloadToUrlMap.removeValue(forKey: task) else { return }

        // Prepare the basic userInfo dictionary that will be posted as part of the notification.
        var userInfo = [String: Any]()
        userInfo[Asset.Keys.name] = asset.stream.name

        if let error = error as NSError? {
            switch (error.domain, error.code) {
            case (NSURLErrorDomain, NSURLErrorCancelled):
                /*
                 This task was canceled. Perform cleanup using the URL saved from
                 `AVAssetDownloadDelegate.urlSession(_:assetDownloadTask:willDownloadTo:).
                 */
                guard let localFileLocation = localAssetForStream(withName: asset.stream.name)?.urlAsset.url else { return }

                do {
                    try FileManager.default.removeItem(at: localFileLocation)

                    userDefaults.removeObject(forKey: asset.stream.name)
                } catch {
                    logger.error("An error occured trying to delete the contents on disk for \(asset.stream.name): \(error)")
                }

                userInfo[Asset.Keys.downloadState] = Asset.DownloadState.notDownloaded.rawValue

            default:
                fatalError("An unexpected error occured \(error.domain)")
            }
        } else {
            do {
                let bookmark = try downloadURL.bookmarkData()

                userDefaults.set(bookmark, forKey: asset.stream.name)
            } catch {
                logger.error("Failed to create bookmarkData for download URL.")
            }

            userInfo[Asset.Keys.downloadState] = Asset.DownloadState.downloaded.rawValue
            userInfo[Asset.Keys.downloadSelectionDisplayName] = ""
        }

        NotificationCenter.default.post(name: .AssetDownloadStateChanged, object: nil, userInfo: userInfo)
    }

    /// Method called when the an `AVAssetDownloadTask` determines the location this asset is downloaded to.
    func urlSession(_ session: URLSession, assetDownloadTask avAssetDownloadTask: AVAssetDownloadTask,
                    willDownloadTo location: URL) {

        /*
         Only use this delegate callback to save the location URL
         somewhere in your app. Any additional work should be done in
         `URLSessionTaskDelegate.urlSession(_:task:didCompleteWithError:)`.
         */

        willDownloadToUrlMap[avAssetDownloadTask] = location
    }
    
    /// Method called when the an `AVAssetDownloadTask` determines the variants it downloads.
    func urlSession(_ session: URLSession, assetDownloadTask avAssetDownloadTask: AVAssetDownloadTask,
                    willDownloadVariants variants: [AVAssetVariant]) {

        /*
         Use this delegate callback to display or record
         the variants that the download task downloads.
         */
        let variantsDescription = variants.map { variant -> String in
            guard let peakBitRate = variant.peakBitRate else { return "N/A" }
            guard let resolution = variant.videoAttributes?.presentationSize else { return "N/A" }
            return "peakBitRate=\(peakBitRate) & resolution=\(Int(resolution.width)) x \(Int(resolution.height))"
        }.joined(separator: ", ")
        
        logger.info("Will download the following variants: \(variantsDescription)")
    }
}

extension Notification.Name {
    /// Notification for when download progress has changed.
    static let AssetDownloadProgress = Notification.Name(rawValue: "AssetDownloadProgressNotification")
    
    /// Notification for when the download state of an `Asset` has changed.
    static let AssetDownloadStateChanged = Notification.Name(rawValue: "AssetDownloadStateChangedNotification")
    
    /// Notification for when `AssetPersistenceManager` has completely restored its state.
    static let AssetPersistenceManagerDidRestoreState = Notification.Name(rawValue: "AssetPersistenceManagerDidRestoreStateNotification")
}
