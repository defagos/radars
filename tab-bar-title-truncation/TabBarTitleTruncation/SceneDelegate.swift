import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private static func rootViewController() -> UIViewController {
        let viewController1 = ViewController()
        viewController1.tabBarItem = UITabBarItem(title: "Vidéos", image: UIImage(systemName: "video"), tag: 0)
        
        let viewController2 = ViewController()
        viewController2.tabBarItem = UITabBarItem(title: "Audios", image: UIImage(systemName: "waveform"), tag: 1)
        
        let viewController3 = ViewController()
        viewController3.tabBarItem = UITabBarItem(title: "Directs", image: UIImage(systemName: "play.fill"), tag: 2)
        
        let viewController4 = ViewController()
        viewController4.tabBarItem = UITabBarItem(title: "Recherche", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        
        let viewController5 = ViewController()
        viewController5.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(systemName: "person"), tag: 4)
        
        let tabBarController = UITabBarController()
        customizeTabBar(tabBarController.tabBar)
        tabBarController.viewControllers = [viewController1, viewController2, viewController3, viewController4, viewController5]
        return tabBarController
    }
    
    private static func customizeTabBar(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        let normalColor = UIColor.red
        let selectedColor = UIColor.blue
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: normalColor
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: selectedColor
        ]
        
        let stackedAppearance = UITabBarItemAppearance(style: .stacked)
        stackedAppearance.normal.titleTextAttributes = normalAttributes
        stackedAppearance.normal.iconColor = normalColor
        stackedAppearance.selected.titleTextAttributes = selectedAttributes
        stackedAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance = stackedAppearance
        
        let inlineAppearance = UITabBarItemAppearance(style: .inline)
        inlineAppearance.normal.titleTextAttributes = normalAttributes
        inlineAppearance.normal.iconColor = normalColor
        inlineAppearance.selected.titleTextAttributes = selectedAttributes
        inlineAppearance.selected.iconColor = selectedColor
        appearance.inlineLayoutAppearance = inlineAppearance
        
        tabBar.standardAppearance = appearance
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        window.rootViewController = Self.rootViewController()
    }
}

