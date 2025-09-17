import SwiftUI

struct ContentView: View {
    @State private var progress: Float = 0

    var body: some View {
        Slider(value: $progress) { isEditing in
            print("--> isEditing: \(isEditing)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
