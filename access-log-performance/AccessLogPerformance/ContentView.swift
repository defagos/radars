import AVFoundation
import AVKit
import Combine
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://stxt-audiostreaming.akamaized.net/hls/live/2117380/couleur3/master.m3u8")!
    )
    @State private var accessLogSize: Int = 0

    var body: some View {
        VStack {
            VideoPlayer(player: player)
            LabeledContent("Access log size", value: String(accessLogSize))
                .padding()
        }
        .onAppear(perform: player.play)
        .onReceive(accessLogSizePublisher()) { size in
            accessLogSize = size
        }
    }

    private func accessLogSizePublisher() -> AnyPublisher<Int, Never> {
        NotificationCenter.default.publisher(for: AVPlayerItem.newAccessLogEntryNotification)
            .compactMap { notification in
                guard let item = notification.object as? AVPlayerItem else { return nil }
                return item.accessLog()?.events.count
            }
            .eraseToAnyPublisher()
    }
}

#Preview {
    ContentView()
}
