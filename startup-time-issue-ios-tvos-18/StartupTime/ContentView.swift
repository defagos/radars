import AVFoundation
import AVKit
import Combine
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
    )
    @State private var startupTime: TimeInterval = 0

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear(perform: player.play)
            .onReceive(lastStartupTimePublisher()) { time in
                startupTime = time
            }
            .overlay(alignment: .topTrailing) {
                Text("Startup time: \(startupTime)s")
                    .padding()
                    .background(.red)
                    .offset(y: 100)
            }
    }

    private func lastStartupTimePublisher() -> AnyPublisher<TimeInterval, Never> {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .compactMap { _ in player.currentItem?.accessLog()?.events.last }
            .map(\.startupTime)
            .eraseToAnyPublisher()
    }
}

#Preview {
    ContentView()
}
