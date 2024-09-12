import AVFoundation
import SwiftUI

private final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        return true
    }
}

@main
struct VideoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
