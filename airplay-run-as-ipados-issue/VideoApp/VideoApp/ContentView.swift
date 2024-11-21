import AVFoundation
import MobileVideoLibraryFB15343579
import SwiftUI

struct ContentView: View {
    var body: some View {
        AwesomeVideoPlayer(
            url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")!
        )
        .ignoresSafeArea()
        .onReceive(
            NotificationCenter.default.publisher(for: AVPlayerItem.failedToPlayToEndTimeNotification)) { notification in
                if let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error {
                    print("--> Failed to play to end time: \(error)")
                }
            }
    }
}

#Preview {
    ContentView()
}
