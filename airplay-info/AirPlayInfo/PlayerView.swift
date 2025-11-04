import AVKit
import Combine
import SwiftUI

struct PlayerView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    var body: some View {
        VideoPlayer(player: player)
            .onAppear(perform: player.play)
            .onReceive(currentItemInfoPublisher()) { info in
                print("--> \(String(describing: info))")
            }
            .ignoresSafeArea()
    }

    private func currentItemInfoPublisher() -> AnyPublisher<ItemInfo?, Never> {
        player.publisher(for: \.currentItem)
            .map { item -> AnyPublisher<ItemInfo?, Never> in
                guard let item else { return Just(nil).eraseToAnyPublisher() }
                return Publishers.CombineLatest(
                    item.publisher(for: \.presentationSize).eraseToAnyPublisher(),
                    item.publisher(for: \.tracks).eraseToAnyPublisher()
                )
                .map { ItemInfo(presentationSize: $0, tracks: $1) }
                .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
