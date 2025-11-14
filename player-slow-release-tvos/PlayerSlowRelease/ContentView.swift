import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: openPlayer) {
            Text("Open player")
        }
        .fullScreenCover(isPresented: $isPresented) {
            PlayerView()
        }
    }

    private func openPlayer() {
        isPresented.toggle()
    }
}

#Preview {
    ContentView()
}
