import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()

    var body: some View {
        VStack {
            Text(model.currentUrl?.absoluteString ?? "No content")
                .font(.caption)
                .padding()

            VideoPlayer(player: model.player)

            Button(action: model.replaceCurrentWithMP3) {
                Text("Replace current with MP3")
            }
            .padding()
        }
        .onAppear(perform: model.play)
    }
}

#Preview {
    ContentView()
}
