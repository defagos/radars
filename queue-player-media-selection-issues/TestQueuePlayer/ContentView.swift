import AVFoundation
import AVKit
import Combine
import SwiftUI

struct ContentView: View {
    @State private var player = AVQueuePlayer(items: [
        .init(url: URL(string: "https://events-delivery.apple.com/0105cftwpxxsfrpdwklppzjhjocakrsk/m3u8/vod_index-PQsoJoECcKHTYzphNkXohHsQWACugmET.m3u8")!),
        .init(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/adv_dv_atmos/main.m3u8")!),
    ])

    var body: some View {
        VideoPlayer(player: player)
            .onAppear(perform: player.play)
            .onReceive(currentMediaSelectionPublisher()) { selection in
                print("--> \(selection)")
            }
    }

    private func currentMediaSelectionPublisher() -> AnyPublisher<AVMediaSelection, Never> {
        player.publisher(for: \.currentItem)
            .compactMap { item -> AnyPublisher<AVMediaSelection, Never>? in
                guard let item else { return nil }
                return item.publisher(for: \.currentMediaSelection).eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}

#Preview {
    ContentView()
}
