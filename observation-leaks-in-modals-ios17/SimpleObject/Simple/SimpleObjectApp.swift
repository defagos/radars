import SwiftUI

@main
struct SimpleObjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SheetExampleView()
                    .tabItem {
                        Text("Sheet")
                    }
                EmbedExampleView()
                    .tabItem {
                        Text("Embed")
                    }
            }
        }
    }
}
