import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private static func appearance() -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .red
        
        let itemAppearance = UITabBarItemAppearance(style: .inline)
        itemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50),
            NSAttributedString.Key.foregroundColor: UIColor.blue
        ]
        appearance.inlineLayoutAppearance = itemAppearance
        
        return appearance
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.standardAppearance = Self.appearance()
        tabBarController.viewControllers = [
            ViewController(title: "First"),
            ViewController(title: "Second"),
            ViewController(title: "Third")
        ]
        window?.rootViewController = tabBarController
        
        return true
    }
}

