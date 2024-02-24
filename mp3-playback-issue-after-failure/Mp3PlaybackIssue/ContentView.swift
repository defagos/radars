import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var player = AVQueuePlayer(url: URL(string: "https://unavailable.mp3")!)

    var body: some View {
        VStack(spacing: 30) {
            Button(action: replaceFailed) {
                Text("Replace failed MP3")
            }
            Button(action: replaceFailedWithWorkaround) {
                Text("Replace MP3 (with workaround)")
            }
            Button(action: resetToFailed) {
                Text("Reset to failed MP3")
            }
        }
        .onReceive(player.publisher(for: \.currentItem)) { item in
            print("--> Current item updated to item: \(String(describing: item))")
        }
        .onAppear {
            player.play()
        }
    }

    private func replaceFailed() {
        let url = Bundle.main.url(forResource: "MP3", withExtension: "mp3")!
        // Replacing a failed MP3 with another playable one does not work. Sound is missing.
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }

    private func replaceFailedWithWorkaround() {
        let url = Bundle.main.url(forResource: "MP3", withExtension: "mp3")!
        // Removing all items before replacing a failed MP3 with another playable one works.
        player.removeAllItems()
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }

    private func resetToFailed() {
        let url = URL(string: "https://unavailable.mp3")!
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
    }
}

#Preview {
    ContentView()
}
