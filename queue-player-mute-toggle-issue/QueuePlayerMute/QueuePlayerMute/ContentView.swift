import AVKit
import SwiftUI

struct ContentView: View {
    @State private var player = AVQueuePlayer(items: [
        .init(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!),
        .init(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8")!)
    ])

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }
}

#Preview {
    ContentView()
}
