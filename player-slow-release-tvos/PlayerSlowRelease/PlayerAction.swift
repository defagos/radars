import AVKit
import UIKit

struct PlayerAction {
    let title: String
    let systemImage: String
    let handler: () -> Void

    func toInfoViewAction(for playerViewController: AVPlayerViewController) -> UIAction {
        .init(title: title, image: UIImage(systemName: systemImage)) { [weak playerViewController] _ in
            handler()
            playerViewController?.dismiss(animated: true)
        }
    }

    func toContextualAction(for playerViewController: AVPlayerViewController) -> UIAction {
        .init(title: title, image: UIImage(systemName: systemImage)) { _ in
            handler()
        }
    }
}

