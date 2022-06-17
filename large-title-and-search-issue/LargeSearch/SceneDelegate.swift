import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
        let navigationController = UINavigationController(rootViewController: BrowserViewController.browserViewController())
#if os(iOS)
        navigationController.navigationBar.prefersLargeTitles = true
#endif
        
        window.rootViewController = navigationController
    }
}
