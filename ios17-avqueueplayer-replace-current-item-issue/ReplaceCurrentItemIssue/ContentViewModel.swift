import AVFoundation
import Combine

final class ContentViewModel: ObservableObject {
    let player = AVQueuePlayer(items: [
        .init(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!),
        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/14132129/fad9b3f0-ca28-3ba0-8d8d-7e0ee2ce3337.mp3")!)
    ])

    @Published private(set) var currentUrl: URL?

    init() {
        player.publisher(for: \.currentItem)
            .map { item in
                guard let asset = item?.asset as? AVURLAsset else { return nil }
                return asset.url
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentUrl)
    }

    func play() {
        player.play()
    }

    func replaceCurrentWithMP3() {
        let item = AVPlayerItem(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/14155342/f7355039-0489-3f14-8c32-82defa4b1499.mp3")!)
        player.replaceCurrentItem(with: item)
    }
}
