import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @State private var topContext = PlaybackContext(
        title: "Bip Bop",
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
    )
    @State private var bottomContext = PlaybackContext(
        title: "The Morning Show",
        url: URL(string: "https://events-delivery.apple.com/0105cftwpxxsfrpdwklppzjhjocakrsk/m3u8/vod_index-PQsoJoECcKHTYzphNkXohHsQWACugmET.m3u8")!
    )

    @State private var isTopSessionActive = true {
        didSet {
            if isTopSessionActive {
                topContext.becomeActiveIfPossible()
            }
            else {
                bottomContext.becomeActiveIfPossible()
            }
        }
    }

    var body: some View {
        VStack {
            BasicPlayerView(player: topContext.player)

            Button(action: swap) {
                Label("Active session (tap to change)", systemImage: isTopSessionActive ? "arrow.up" : "arrow.down")
            }
            .padding()

            BasicPlayerView(player: bottomContext.player)
        }
        .onAppear(perform: play)
    }

    private func play() {
        topContext.player.play()
        bottomContext.player.play()
    }

    private func swap() {
        isTopSessionActive.toggle()
    }
}

#Preview {
    ContentView()
}
