import AVKit
import SwiftUI

struct PlayerView: View {
    @State private var player = AVPlayer()
    @State private var delegate: SlowLoadingResourceLoaderDelegate?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        mainView()
            .onAppear(perform: player.play)
    }

    private func mainView() -> some View {
#if os(tvOS)
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
                            loadPlayableItem()
                        },
                        UIAction(title: "[FIX] Apple Bip Bop 16:9", image: .init(systemName: "apple.logo")) { _ in
                            loadPlayableItemWithFix()
                        }
                    ]
                )
            ])
            .ignoresSafeArea()
#else
        VStack {
            SystemVideoView(player: player)

            HStack(spacing: 40) {
                Button(action: loadSlowLoadingItem) {
                    Label("Slow loading item", systemImage: "tortoise.fill")
                }
                Button(action: loadPlayableItem) {
                    Label("Apple Bip Bop 16:9", systemImage: "apple.logo")
                }
            }
            .padding()

            Button(action: close) {
                Text("Close")
            }
        }
#endif
    }

    private func loadSlowLoadingItem() {
        let asset = AVURLAsset(url: URL(string: "custom://slowloading.m3u8")!)
        delegate = SlowLoadingResourceLoaderDelegate()
        asset.resourceLoader.setDelegate(delegate, queue: .main)
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: item)
    }

    private func loadPlayableItem() {
        let item = AVPlayerItem(
            url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
        )
        player.replaceCurrentItem(with: item)
    }

    private func loadPlayableItemWithFix() {
        let item = AVPlayerItem(
            url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
        )
        player.cancelLoadingAndReplaceCurrentItem(with: item)
    }

    private func close() {
        dismiss()
    }
}

#Preview {
    PlayerView()
}
