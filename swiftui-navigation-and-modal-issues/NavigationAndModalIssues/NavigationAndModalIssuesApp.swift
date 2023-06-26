import SwiftUI

@main
struct NavigationAndModalIssuesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FirstNameView()
            }
        }
    }
}
