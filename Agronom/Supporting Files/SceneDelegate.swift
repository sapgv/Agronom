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
        
        
        let taskListViewController = self.taskListViewController()
        
        let operationListViewController = self.operationListViewController()
        
        let vehicleListViewController = self.vehicleListViewController()
        
        let toolListViewController = self.toolListViewController()
        
        let fieldListViewController = self.fieldListViewController()
        
        let workerListViewController = self.workerListViewController()
        
        appTabBarViewController.setViewControllers([taskListViewController, operationListViewController, vehicleListViewController, toolListViewController, fieldListViewController, workerListViewController], animated: false)
        
        appTabBarViewController.selectedIndex = 0
        
        self.window?.rootViewController = appTabBarViewController
        
        self.window?.makeKeyAndVisible()
        
    }

    func taskListViewController() -> UIViewController {
        
        let taskListViewController = TaskListViewController()

        let taskNavigationController = UINavigationController(rootViewController: taskListViewController)
        taskNavigationController.tabBarItem = UITabBarItem(title: "Задачи", image: nil, tag: 0)
        
        return taskNavigationController
        
    }
    
    func operationListViewController() -> UIViewController {
        
        let operationListViewController = OperationListViewController()
        
        
        let operationNavigationController = UINavigationController(rootViewController: operationListViewController)
        operationNavigationController.tabBarItem = UITabBarItem(title: "Операции", image: nil, tag: 1)
        
        return operationNavigationController
        
    }
    
    func vehicleListViewController() -> UIViewController {
        
        let vehicleListViewController = VehicleListViewController()
        
        let vehicleNavigationController = UINavigationController(rootViewController: vehicleListViewController)
        vehicleNavigationController.tabBarItem = UITabBarItem(title: "Механика", image: nil, tag: 2)
        
        return vehicleNavigationController
        
    }
    
    func toolListViewController() -> UIViewController {
        
        let toolListViewController = ToolListViewController()
        
        let toolNavigationController = UINavigationController(rootViewController: toolListViewController)
        toolNavigationController.tabBarItem = UITabBarItem(title: "Оборудование", image: nil, tag: 3)
        
        return toolNavigationController
        
    }
    
    func fieldListViewController() -> UIViewController {
        
        let fieldListViewController = FieldListViewController()
        
        let fieldNavigationController = UINavigationController(rootViewController: fieldListViewController)
        fieldNavigationController.tabBarItem = UITabBarItem(title: "Поля", image: nil, tag: 4)
        
        return fieldNavigationController
        
    }
    
    func workerListViewController() -> UIViewController {
        
        let workerListViewController = WorkerListViewController()
        
        let workerNavigationController = UINavigationController(rootViewController: workerListViewController)
        workerNavigationController.tabBarItem = UITabBarItem(title: "Работники", image: nil, tag: 5)
        
        return workerNavigationController
        
    }
    

}

