import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )

    @State private var allowsPictureInPicturePlayback = true

    var body: some View {
        VStack {
            mainView()
            settingsView()
        }
        .onAppear(perform: player.play)
    }

    @ViewBuilder
    private func mainView() -> some View {
        if allowsPictureInPicturePlayback {
            SystemPlayerView(player: player)
        }
        else {
            BasicVideoView(player: player)
        }
    }

    private func settingsView() -> some View {
        Toggle(isOn: $allowsPictureInPicturePlayback) {
            Text("Allows Picture in Picture playback")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
