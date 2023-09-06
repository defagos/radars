import SwiftUI

struct EmbedExampleView: View {
    @State private var isVisible = false

    var body: some View {
        VStack {
            if isVisible {
                DetailView()
            }
            Button(action: { isVisible.toggle() }) {
                Text("Toggle embed")
            }
            .frame(height: 100)
        }
    }
}

#Preview {
    EmbedExampleView()
}
