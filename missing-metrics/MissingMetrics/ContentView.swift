import AVFoundation
import AVKit
import SwiftUI

struct ContentView: View {
    @State private var player = AVPlayer(
        playerItem: AVPlayerItem.fairPlayProtected(
            url: URL(string: "https://rts1-lsvs.akamaized.net/out/v1/62441d2399f14dce9e558b5503edba11/index.m3u8?dw=7200")!,
            certificateUrl: URL(string: "https://srg.live.ott.irdeto.com/licenseServer/streaming/v1/SRG/getcertificate?applicationId=live")!
        )
    )

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                if let currentItem = player.currentItem {
                    Task {
                        for try await event in currentItem.metrics(forType: AVMetricContentKeyRequestEvent.self) {
                            print("--> \(event.mediaResourceRequestEvent)")
                        }
                    }
                }
                player.play()
            }
    }
}

#Preview {
    ContentView()
}
