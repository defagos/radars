import AVFoundation
import SwiftUI

struct BasicPlayerView: View {
    let player: AVPlayer

    @State private var rate: Float = 0

    var body: some View {
        ZStack {
            VideoView(player: player)
            Color(white: 0, opacity: 0.4)
            playbackButton()
        }
        .onReceive(player.publisher(for: \.rate)) { newValue in
            rate = newValue
        }
    }

    @ViewBuilder
    private func playbackButton() -> some View {
        Button(action: player.togglePlayPause) {
            Image(systemName: playbackImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 90)
                .tint(.white)
        }
    }

    private var playbackImageName: String {
        rate == 0 ? "play.circle.fill" : "pause.circle.fill"
    }
}
