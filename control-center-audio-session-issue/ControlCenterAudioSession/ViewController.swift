import AVKit
import MediaPlayer
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
    }

    private func updateControlCenter() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: "Bip bop"
        ]

        let commandCenter = MPRemoteCommandCenter.shared()

        let playCommand = commandCenter.playCommand
        playCommand.addTarget { _ in
            self.player?.play()
            return .success
        }

        let pauseCommand = commandCenter.pauseCommand
        pauseCommand.addTarget { _ in
            self.player?.pause()
            return .success
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        if self.player == nil {
            let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!
            
            let player = AVPlayer(url: url)
            playerLayer.player = player
            
            self.player = player

            updateControlCenter()
        }
        self.player!.play()
    }

    @IBAction func pause(_ sender: UIButton) {
        self.player?.pause()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        self.player = nil
        playerLayer.player = nil
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }

    @IBAction func toggleAudioSessionMixWithOthers(_ sender: UISwitch) {
        if sender.isOn {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
        }
        else {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        }
    }
}
