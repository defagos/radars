import AVKit
import UIKit

class ViewController: UIViewController {
    private var player: AVPlayer?
    private var pictureInPictureController: AVPictureInPictureController?
    
    @IBOutlet private weak var playerContainerView: UIView!
    @IBOutlet private weak var pipSwitch: UISwitch!
    
    private weak var playerView: PlayerView!
    
    private var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerView = PlayerView()
        playerView.frame = playerContainerView.bounds
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerContainerView.addSubview(playerView)
        self.playerView = playerView
    }
    
    @IBAction func play(_ sender: UIButton) {
        let url = URL(string: "https://srgplayerswivod-vh.akamaihd.net/i/41981254/,video,.mp4.csmil/master.m3u8")!
        
        let player = AVPlayer(url: url)
        player.play()
        self.player = player
        
        let playerLayer = playerView.playerLayer
        playerLayer.player = player
        
        if AVPictureInPictureController.isPictureInPictureSupported() && pipSwitch.isOn {
            observer = playerLayer.observe(\.isReadyForDisplay, options: .new) { [weak self] playerLayer, change in
                guard let self = self else { return }
                
                if let isReadyForDisplay = change.newValue {
                    if isReadyForDisplay {
                        self.pictureInPictureController = AVPictureInPictureController(playerLayer: playerLayer)
                    }
                    else {
                        self.pictureInPictureController = nil
                    }
                }
            }
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        self.player = nil;
        playerView.playerLayer.player = nil
        observer = nil
    }
    
    @IBAction func togglePictureInPicture(_ sender: UIButton) {
        guard let pictureInPictureController = pictureInPictureController else { return }
        if pictureInPictureController.isPictureInPictureActive {
            pictureInPictureController.stopPictureInPicture()
        }
        else {
            pictureInPictureController.startPictureInPicture()
        }
    }
}

