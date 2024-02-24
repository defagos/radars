import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var player = AVQueuePlayer(url: URL(string: "https://unavailable.mp3")!)

    var body: some View {
        VStack(spacing: 30) {
            Button(action: replaceWithPlayableMp3) {
                Text("Replace with playable MP3")
            }
            Button(action: replaceWithPlayableMp3WithWorkaround) {
                Text("Replace with playable MP3 (clear first)")
            }
            Button(action: resetToUnplayableMp3) {
                Text("Reset to unplayable MP3")
            }
        }
        .onReceive(player.publisher(for: \.currentItem)) { item in
            print("--> Current item updated to item: \(String(describing: item))")
        }
        .onAppear {
            player.play()
        }
    }

    private func replaceWithPlayableMp3() {
        let url = Bundle.main.url(forResource: "MP3", withExtension: "mp3")!
        // Replacing a failed MP3 with another playable one does not work. Sound is missing.
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }

    private func replaceWithPlayableMp3WithWorkaround() {
        let url = Bundle.main.url(forResource: "MP3", withExtension: "mp3")!
        // Removing all items before replacing a failed MP3 with another playable one works.
        player.removeAllItems()
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }

    private func resetToUnplayableMp3() {
        let url = URL(string: "https://unavailable.mp3")!
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }
}

#Preview {
    ContentView()
}
