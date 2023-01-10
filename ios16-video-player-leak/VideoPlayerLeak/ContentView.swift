import AVKit
import SwiftUI

private struct VideoPlayerView: View {
    @State private var player = AVPlayer(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!)

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
    }
}

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: action) {
            Text("Show player")
        }
        .sheet(isPresented: $isPresented) {
            VideoPlayerView()
        }
    }

    private func action() {
        isPresented.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
