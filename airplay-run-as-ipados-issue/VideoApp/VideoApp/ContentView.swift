import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
    )

    var body: some View {
        VideoPlayer(player: player)
            .onAppear(perform: player.play)
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
