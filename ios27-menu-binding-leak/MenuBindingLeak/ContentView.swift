import SwiftUI
import Playgrounds

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: showModal) {
            Text("Show modal")
        }
        .sheet(isPresented: $isPresented) {
            ModalView()
        }
    }

    private func showModal() {
        isPresented.toggle()
    }
}

#Preview {
    ContentView()
}
