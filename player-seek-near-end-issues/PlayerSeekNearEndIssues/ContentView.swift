import AVKit
import Combine
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    @State private var error: Error?

    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .ignoresSafeArea()
                .onAppear(perform: player.play)
                .onReceive(errorPublisher()) { self.error = $0 }
            if let error {
                Text(error.localizedDescription)
            }
        }
    }

    private func errorPublisher() -> AnyPublisher<Error, Never> {
        player.publisher(for: \.currentItem)
            .compactMap { item -> AnyPublisher<Error, Never>? in
                guard let item else { return nil }
                return NotificationCenter.default.publisher(for: .AVPlayerItemFailedToPlayToEndTime, object: item)
                    .compactMap { notification in
                        notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error
                    }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}
