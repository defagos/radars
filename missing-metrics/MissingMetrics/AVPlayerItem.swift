import AVFoundation

private let kContentKeySession = AVContentKeySession(keySystem: .fairPlayStreaming)
private let kContentKeySessionQueue = DispatchQueue(label: "ch.defagos.player.content_key_session")
private var delegate: ContentKeySessionDelegate?

extension AVPlayerItem {
    static func fairPlayProtected(url: URL, certificateUrl: URL) -> AVPlayerItem {
        let asset = AVURLAsset(url: url)
        delegate = ContentKeySessionDelegate(certificateUrl: certificateUrl)
        kContentKeySession.setDelegate(
            delegate,
            queue: kContentKeySessionQueue
        )
        kContentKeySession.addContentKeyRecipient(asset)
        kContentKeySession.processContentKeyRequest(withIdentifier: nil, initializationData: nil)
        return AVPlayerItem(asset: asset)
    }
}
