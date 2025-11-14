import AVKit
import SwiftUI

struct SystemVideoView: UIViewControllerRepresentable {
    let player: AVPlayer

    private var _contextualActions: [PlayerAction] = []
    private var _infoViewActions: [PlayerAction] = []

    init(player: AVPlayer) {
        self.player = player
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
        uiViewController.contextualActions = _contextualActions.map { $0.toContextualAction(for: uiViewController) }
        uiViewController.infoViewActions = _infoViewActions.map { $0.toInfoViewAction(for: uiViewController) }
    }
}

extension SystemVideoView {
    func contextualActions(_ actions: [PlayerAction]) -> Self {
        var view = self
        view._contextualActions = actions
        return view
    }

    func infoViewActions(_ actions: [PlayerAction]) -> Self {
        var view = self
        view._infoViewActions = actions
        return view
    }
}
