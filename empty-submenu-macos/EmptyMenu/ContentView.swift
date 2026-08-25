import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        Menu {
            Menu {
                ForEach(1..<10) { i in
                    Text("Item \(i)")
                }
            } label: {
                Text("Filled")
            }
            Menu {
                ForEach(0..<0) { i in
                    Text("Item \(i)")
                }
            } label: {
                Text("Empty")
            }
        } label: {
            Text("Menu")
        }
    }
}

#Preview {
    ContentView()
}
