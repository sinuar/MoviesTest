//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        coordinator = MainCoordinator(rootViewController: UINavigationController(), viewControllerFactory: iOSCoordinatorFactory())
        coordinator?.start()
        
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
        
    }

}
