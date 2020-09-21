import AVKit
import UIKit

class ViewController: UIViewController {
    private var player: AVPlayer?
    
    @IBOutlet private weak var playerContainerView: UIView!
    private weak var playerView: PlayerView!
    
    var playerLayer: AVPlayerLayer {
        return playerView.playerLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerView = PlayerView()
        playerView.frame = playerContainerView.bounds
        playerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerContainerView.addSubview(playerView)
        self.playerView = playerView
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @IBAction func play(_ sender: UIButton) {
        if self.player == nil {
            let url = URL(string: "https://srgplayerswivod-vh.akamaihd.net/i/41981254/,video,.mp4.csmil/master.m3u8")!
            
            let player = AVPlayer(url: url)
            playerLayer.player = player
            
            self.player = player
        }
        self.player!.play()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        self.player = nil
        playerLayer.player = nil
    }
    
    @objc func applicationDidEnterBackground(_ notification: Notification) {
        playerLayer.player = nil
    }
    
    @objc func applicationWillEnterForeground(_ notification: Notification) {
        playerLayer.player = player
    }
}
