import AVFoundation
import UIKit

final class PlayerView: UIView {
    override class var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        self.layer as! AVPlayerLayer
    }
}
