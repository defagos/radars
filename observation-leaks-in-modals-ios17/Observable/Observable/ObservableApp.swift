import SwiftUI

@main
struct ObservableApp: App {
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
