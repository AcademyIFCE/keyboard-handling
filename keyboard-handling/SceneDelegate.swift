import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let controllers = [VC1(), VC2(), VC3(), VC4()].map { UINavigationController(rootViewController: $0) }
        
        controllers.enumerated().forEach {
            $1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "\($0+1).circle.fill"), tag: $0)
        }
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = controllers
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
    }
    
}

