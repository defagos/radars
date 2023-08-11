import SwiftUI

private enum PlayerKind: Identifiable {
    case simple
    case resourceLoaded

    var id: Self {
        self
    }
}

struct ContentView: View {
    @State private var playerKind: PlayerKind?

    var body: some View {
        VStack(spacing: 40) {
            Button(action: { playerKind = .simple }) {
                Text("Open simple player")
            }
            Button(action: { playerKind = .resourceLoaded }) {
                Text("Open resource loaded player")
            }
        }
        .sheet(item: $playerKind) { playerKind in
            switch playerKind {
            case .simple:
                SimplePlayerView()
            case .resourceLoaded:
                ResourceLoadedPlayerView()
            }
        }
    }
}

#Preview {
    ContentView()
}
