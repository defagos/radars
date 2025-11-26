import AVKit
import SwiftUI

struct PlayerView: View {
    @State private var player = AVPlayer(playerItem: item())

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear(perform: player.play)
    }
}

private extension PlayerView {
    static func chapter(withIndex index: Int32) -> AVTimedMetadataGroup {
        AVTimedMetadataGroup(
            items: [
                .init(identifier: .commonIdentifierTitle, value: "Chapter \(index)"),
                .init(identifier: .commonIdentifierArtwork, value: UIImage(named: "\(index)")!.pngData())
            ].compactMap(\.self),
            timeRange: CMTimeRange(
                start: CMTimeMultiply(CMTime(value: 300, timescale: 1), multiplier: index),
                duration: CMTime(seconds: 120, preferredTimescale: 1)
            )
        )
    }

    static func item() -> AVPlayerItem {
        let item = AVPlayerItem(
            url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!
        )
#if os(tvOS)
        item.navigationMarkerGroups = [
            AVNavigationMarkersGroup(
                title: "chapters",
                timedNavigationMarkers: (1...5).map { chapter(withIndex: $0) }
            )
        ]
#endif
        return item
    }
}
