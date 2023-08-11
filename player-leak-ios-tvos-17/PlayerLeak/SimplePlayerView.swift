import AVKit
import SwiftUI

struct SimplePlayerView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }
}

#Preview {
    SimplePlayerView()
}
