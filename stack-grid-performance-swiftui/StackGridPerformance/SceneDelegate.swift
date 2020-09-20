import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.makeKeyAndVisible()
            self.window = window
            
            let stackExampleViewController = UIHostingController(rootView: StackExample())
            stackExampleViewController.tabBarItem = UITabBarItem(title: "Stacks", image: nil, tag: 0)
            
            let lazyStackExampleViewController = UIHostingController(rootView: LazyStackExample())
            lazyStackExampleViewController.tabBarItem = UITabBarItem(title: "Lazy stacks", image: nil, tag: 1)
            
            let collectionExampleViewController = CollectionExampleViewController()
            collectionExampleViewController.tabBarItem = UITabBarItem(title: "Collection", image: nil, tag: 3)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [stackExampleViewController,
                                                lazyStackExampleViewController,
                                                collectionExampleViewController]
            window.rootViewController = tabBarController
        }
    }
}

