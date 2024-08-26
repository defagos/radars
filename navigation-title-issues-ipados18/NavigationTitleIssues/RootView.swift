import SwiftUI

private struct FirstView: View {
    var body: some View {
        Text("First")
            .navigationTitle("First")
    }
}

private struct SecondView: View {
    var body: some View {
        Text("Second")
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Second")
    }
}

private struct ThirdView: View {
    var body: some View {
        Text("Third")
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Third")
            .toolbarTitleMenu {
                Text("Menu item 1")
                Text("Menu item 2")
                Text("Menu item 3")
            }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FirstView()
            }
            .tabItem {
                Label("First", systemImage: "1.square")
            }

            NavigationStack {
                SecondView()
            }
            .tabItem {
                Label("Second", systemImage: "2.square")
            }

            NavigationStack {
                ThirdView()
            }
            .tabItem {
                Label("Third", systemImage: "3.square")
            }
        }
    }
}

#Preview {
    RootView()
}
