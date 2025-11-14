import AVKit
import SwiftUI

struct PlayerView: View {
    @State private var player = AVPlayer()
    @State private var delegate = SlowLoadingResourceLoaderDelegate()

    var body: some View {
        SystemVideoView(player: player)
            .contextualActions([
                .init(title: "Slow loading item", systemImage: "tortoise.fill") {
                    player.replaceCurrentItem(with: slowLoadingItem())
                },
                .init(title: "Playable item", systemImage: "hand.thumbsup.fill") {
                    replaceCurrentItem()
                }
            ])
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
    }

    private func slowLoadingItem() -> AVPlayerItem {
        let asset = AVURLAsset(url: URL(string: "custom://slowloading.m3u8")!)
        asset.resourceLoader.setDelegate(delegate, queue: .main)
        return .init(asset: asset)
    }

    private func replaceCurrentItem() {
        let item = AVPlayerItem(
            url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
        )
        item.externalMetadata = [
            .init(identifier: .commonIdentifierTitle, value: "Title")
        ].compactMap(\.self)
        player.replaceCurrentItem(with: item)
    }
}

#Preview {
    PlayerView()
}
