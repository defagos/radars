import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    private let player = AVQueuePlayer(items: [
        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13698523/c4722391-23a8-31da-b9c6-bf0f7a6b382b.mp3")!),
        .init(url: URL(string: "https://rts-aod-dd.akamaized.net/ww/13705229/e1f73787-7d8c-3f25-9e06-0de092dc38ae.mp3")!)
    ])

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                player.play()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
