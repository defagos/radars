import AVKit
import SwiftUI

struct SystemVideoView: UIViewControllerRepresentable {
    let player: AVPlayer

    private var _transportBarCustomMenuItems: [UIMenuElement] = []

    init(player: AVPlayer) {
        self.player = player
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
#if os(tvOS)
        uiViewController.transportBarCustomMenuItems = _transportBarCustomMenuItems
#endif
    }
}

#if os(tvOS)

extension SystemVideoView {
    func transportBarCustomMenuItems(_ items: [UIMenuElement]) -> Self {
        var view = self
        view._transportBarCustomMenuItems = items
        return view
    }
}

#endif
