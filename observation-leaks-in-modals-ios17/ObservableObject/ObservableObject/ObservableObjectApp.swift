import SwiftUI

@main
struct ObservableObjectApp: App {
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
