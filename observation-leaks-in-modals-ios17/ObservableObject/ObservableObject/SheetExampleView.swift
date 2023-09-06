import SwiftUI

struct SheetExampleView: View {
    @State private var isPresented = false

    var body: some View {
        Button(action: { isPresented.toggle() }) {
            Text("Show modal")
        }
        .sheet(isPresented: $isPresented) {
            DetailView()
        }
    }
}

#Preview {
    SheetExampleView()
}
