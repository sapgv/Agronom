//
//  SceneDelegate.swift
//  Agronom
//
//  Created by Grigory Sapogov on 17.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let appTabBarViewController = AppTabViewController()
        
        self.window = UIWindow(windowScene: scene)
        
        self.window?.rootViewController = appTabBarViewController
        
        
        let mainViewController = self.mainViewController()
        
        let solaryListViewController = self.solaryListViewController()
        
        appTabBarViewController.setViewControllers([mainViewController,
                                                    solaryListViewController], animated: false)
        
        appTabBarViewController.selectedIndex = 0
        
        self.window?.rootViewController = appTabBarViewController
        
        self.window?.makeKeyAndVisible()
        
    }
    
    func mainViewController() -> UIViewController {
        
        let mainViewController = MainViewController()
        
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        let image = UIImage(systemName: "house")
        mainNavigationController.tabBarItem = UITabBarItem(title: "Главная", image: image, tag: 0)
        
        return mainNavigationController
        
    }

    func solaryListViewController() -> UIViewController {
        
        let solaryListViewController = SolaryListViewController()
        
        let solaryNavigationController = UINavigationController(rootViewController: solaryListViewController)
        let image = UIImage(systemName: "menucard")
        solaryNavigationController.tabBarItem = UITabBarItem(title: "Зарплата", image: image, tag: 1)
        
        return solaryNavigationController
        
    }
    

}

