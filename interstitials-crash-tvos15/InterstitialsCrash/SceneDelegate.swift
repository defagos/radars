import AVKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8")!)
        playerViewController.player?.play()
        window?.rootViewController = playerViewController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            playerViewController.player = nil           // <--- No crash occurs if this line is commented out
            playerViewController.player = AVPlayer(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!)
            playerViewController.player?.play()
        }
    }
}
