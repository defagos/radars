import AVKit
import SwiftUI

struct SystemPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://tagesschau.akamaized.net/hls/live/2020115/tagesschau/tagesschau_1/master.m3u8")!
    )

    var body: some View {
        SystemPlayerView(player: player)
            .onAppear(perform: player.play)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
