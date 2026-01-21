import AVKit
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://tagesschau.akamaized.net/hls/live/2020115/tagesschau/tagesschau_1/master.m3u8")!
    )

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }
}

#Preview {
    ContentView()
}
