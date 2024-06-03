import SwiftUI

struct ContentView: View {
    @State private var count = 0

    var body: some View {
        HStack(spacing: 20) {
            Button(action: decrement) {
                Text("Decrement")
            }
            .keyboardShortcut(.leftArrow, modifiers: [])

            Text("Count: \(count)")

            Button(action: increment) {
                Text("Increment")
            }
            .keyboardShortcut(.rightArrow, modifiers: [])
        }
    }

    private func decrement() {
        count -= 1
    }

    private func increment() {
        count += 1
    }
}

#Preview {
    ContentView()
}
