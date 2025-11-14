import AVKit
import SwiftUI

struct PlayerView: View {
    @State private var player = AVPlayer()
    @State private var delegate: SlowLoadingResourceLoaderDelegate?

    var body: some View {
        SystemVideoView(player: player)
            .transportBarCustomMenuItems([
                UIMenu(
                    title: "Load content",
                    image: UIImage(systemName: "list.and.film"),
                    options: [.singleSelection],
                    children: [
                        UIAction(title: "Slow loading item", image: .init(systemName: "tortoise.fill")) { _ in
                            loadSlowLoadingItem()
                        },
                        UIAction(title: "Apple Bip Bop 16:9", image: .init(systemName: "apple.logo")) { _ in
                            loadValidItem()
                        }
                    ]
                )
            ])
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
    }

    private func loadSlowLoadingItem() {
        let asset = AVURLAsset(url: URL(string: "custom://slowloading.m3u8")!)
        delegate = SlowLoadingResourceLoaderDelegate()
        asset.resourceLoader.setDelegate(delegate, queue: .main)
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: item)
    }

    private func loadValidItem() {
        let item = AVPlayerItem(
            url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
        )
        player.replaceCurrentItem(with: item)
    }
}

#Preview {
    PlayerView()
}
