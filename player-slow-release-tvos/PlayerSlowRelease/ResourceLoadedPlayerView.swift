import AVKit
import SwiftUI

final class LoadingResourceLoaderDelegate: NSObject, AVAssetResourceLoaderDelegate {
    func resourceLoader(
        _ resourceLoader: AVAssetResourceLoader,
        shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest
    ) -> Bool {
        true
    }

    func resourceLoader(
        _ resourceLoader: AVAssetResourceLoader,
        shouldWaitForRenewalOfRequestedResource renewalRequest: AVAssetResourceRenewalRequest
    ) -> Bool {
        true
    }
}

private let kLoadingResourceLoaderDelegate = LoadingResourceLoaderDelegate()

struct ResourceLoadedPlayerView: View {
    @State private var player = AVPlayer(playerItem: Self.loadingItem())

    static func loadingItem() -> AVPlayerItem {
        let asset = AVURLAsset(url: URL(string: "custom://loading.m3u8")!)
        asset.resourceLoader.setDelegate(kLoadingResourceLoaderDelegate, queue: .main)
        return .init(asset: asset)
    }

    static func playerItem() -> AVPlayerItem {
        AVPlayerItem(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!)
    }

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                player.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    player.replaceCurrentItem(with: Self.playerItem())
                }
            }
    }
}

#Preview {
    ResourceLoadedPlayerView()
}
