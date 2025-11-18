import AVKit
import SwiftUI

struct SystemVideoView: UIViewControllerRepresentable {
    let player: AVPlayer

    init(player: AVPlayer) {
        self.player = player
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
