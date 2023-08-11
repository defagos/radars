import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: { isPresented.toggle() }) {
            Text("Open player")
        }
        .sheet(isPresented: $isPresented) {
            SimplePlayerView()
        }
    }
}

#Preview {
    ContentView()
}
