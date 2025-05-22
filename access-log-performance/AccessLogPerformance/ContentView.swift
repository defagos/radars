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
            debugPanel()
        }
        .onAppear(perform: player.play)
        .onReceive(accessLogSizePublisher()) { size in
            accessLogSize = size
        }
    }

    private func debugPanel() -> some View {
        VStack {
            LabeledContent("Access log size", value: String(accessLogSize))
            Button(action: dump) {
                Text("Dump access log")
            }
        }
        .padding()
    }

    private func dump() {
        guard let accessLog = player.currentItem?.accessLog(),
              let data = accessLog.extendedLogData(),
              let dump = String(data: data, encoding: .init(rawValue: accessLog.extendedLogDataStringEncoding)) else {
            return
        }
        print(dump)
    }
}

private extension ContentView {
    static func accessLogSizePublisher(for item: AVPlayerItem) -> AnyPublisher<Int, Never> {
        NotificationCenter.default.publisher(for: AVPlayerItem.newAccessLogEntryNotification, object: item)
            .compactMap { notification in
                guard let item = notification.object as? AVPlayerItem else { return nil }
                return item.accessLog()?.events.count
            }
            .eraseToAnyPublisher()
    }

    func accessLogSizePublisher() -> AnyPublisher<Int, Never> {
        player.publisher(for: \.currentItem)
            .map { item in
                guard let item else { return Just(0).eraseToAnyPublisher() }
                return Self.accessLogSizePublisher(for: item)
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }
}

#Preview {
    ContentView()
}
