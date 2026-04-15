import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    var body: some View {
        VStack {
            VideoPlayer(player: player)
            Button(action: printAccessLog) {
                Text("Print access log")
            }
        }
        .onAppear(perform: player.play)
    }

    private func printAccessLog() {
        player.printAccessLog()
    }
}

#Preview {
    ContentView()
}
