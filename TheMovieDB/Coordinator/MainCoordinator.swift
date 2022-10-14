//
//  MainCoordinator.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation
import UIKit

protocol Coordinator {
   var rootViewController: UINavigationController { get set }
   func start()
   func goToFilmCollection()
}

class MainCoordinator: Coordinator {
   var rootViewController: UINavigationController
   var viewControllerFactory: ViewControllerFactory
   
   init(rootViewController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
      self.rootViewController = rootViewController
      self.viewControllerFactory = viewControllerFactory
   }
   
   func start() {
      rootViewController.pushViewController(viewControllerFactory.loginViewController(), animated: false)
   }
   
   func goToFilmCollection() {
      rootViewController.pushViewController(viewControllerFactory.filmCollectionViewController(), animated: true)
   }
}
