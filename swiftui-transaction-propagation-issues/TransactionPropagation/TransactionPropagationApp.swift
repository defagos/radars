import SwiftUI

@main
struct TransactionPropagationApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                StackWrappingExampleView()
                    .tabItem {
                        Label("ZStack", systemImage: "checkmark.circle.fill")
                    }
                UIKitWrappingExampleView()
                    .tabItem {
                        Label("Representable", systemImage: "xmark.circle.fill")
                    }
            }
        }
    }
}
