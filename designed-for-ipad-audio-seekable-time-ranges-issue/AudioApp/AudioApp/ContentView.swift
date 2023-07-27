import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @StateObject private var model = ContentViewModel()

    var body: some View {
        VStack {
            VideoPlayer(player: model.player)
            VStack {
                Text("Loaded: \(model.loadedRangeString)")
                Text("Seekable: \(model.seekableRangeString)")
            }
            .padding()
        }
        .onAppear(perform: model.play)
    }
}

#Preview {
    ContentView()
}
