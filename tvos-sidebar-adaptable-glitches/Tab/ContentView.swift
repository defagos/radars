import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ForEach(1..<12) { index in
                Tab("Page \(index)", systemImage: "circle") {
                    Text("\(index)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
