import SwiftUI

struct ContentView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            RoutePickerView()
                .frame(width: 60)
            Button(action: increment) {
                Text("Increment (now \(count))")
            }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("--> tapped")
                }
        )
        .padding()
    }

    private func increment() {
        count += 1
    }
}

#Preview {
    ContentView()
}
