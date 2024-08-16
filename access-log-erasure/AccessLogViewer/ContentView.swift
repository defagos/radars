import AVFoundation
import AVKit
import Combine
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
    )
    @State private var text: String = ""

    var body: some View {
        VStack {
            VideoPlayer(player: player)
            TextEditor(text: $text)
        }
        .onAppear(perform: player.play)
        .onReceive(accessLogPublisher()) { text = $0 }
    }

    private func accessLogPublisher() -> AnyPublisher<String, Never> {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map { [player] _ in
                guard let accessLog = player.currentItem?.accessLog(), let data = accessLog.extendedLogData(),
                      let accessLogText = String(data: data, encoding: .init(rawValue: accessLog.extendedLogDataStringEncoding)) else {
                    return ""
                }
                return """
                Number of events: \(accessLog.events.count)
                
                \(accessLogText)
                """
            }
            .eraseToAnyPublisher()
    }
}

#Preview {
    ContentView()
}
