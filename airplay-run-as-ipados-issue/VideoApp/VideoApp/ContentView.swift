import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
    )

    var body: some View {
        VideoPlayer(player: player)
            .onAppear(perform: player.play)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
