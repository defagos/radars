import AVKit
import SwiftUI

struct PlayerView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
    )
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        SystemVideoView(player: player)
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }

    private func close() {
        dismiss()
    }
}

#Preview {
    PlayerView()
}
