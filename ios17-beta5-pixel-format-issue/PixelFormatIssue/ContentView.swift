import SwiftUI

struct ContentView: View {
    @State private var isPlaying = false

    var body: some View {
        Button(action: togglePlayPause) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
        }
    }

    private var imageName: String {
        isPlaying ? "pause.circle.fill" : "play.circle.fill"
    }

    private func togglePlayPause() {
        isPlaying.toggle()
    }
}

#Preview {
    ContentView()
}
