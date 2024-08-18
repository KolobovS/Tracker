import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBarVC = TabBarController()
        let onboardingVC = OnboardingPageViewController()
        
        var rootViewController: UIViewController
    
        if OnboardingManager.hasCompletedOnboarding {
            rootViewController = tabBarVC
        } else {
            rootViewController = onboardingVC
        }
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}

