import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {}) {
            Text("First")
                .accessibilityElement()
                .accessibilityLabel("First label")
        }
        Button(action: {}) {
            Text("Second")
                .accessibilityElement()
                .accessibilityLabel("Second label")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
