import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        List {
            Button(action: showModal) {
                Text("Show modal")
            }
            Button(action: showModal) {
                Text("Show modal")
            }
        }
        .sheet(isPresented: $isPresented) {
            Color.red
                .ignoresSafeArea()
        }
    }

    private func showModal() {
        isPresented.toggle()
    }
}

#Preview {
    ContentView()
}
