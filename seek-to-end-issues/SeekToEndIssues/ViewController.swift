import UIKit

final class ViewController: UIViewController {
    @IBAction private func openPlayer(_ sender: Any) {
        let playerViewController = PlayerViewController()
        present(playerViewController, animated: true)
    }
}
