//
//  iOSCoordinatorFactory.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import UIKit

protocol ViewControllerFactory {
   func loginViewController() -> UIViewController
   func filmCollectionViewController() -> UIViewController
}

class iOSCoordinatorFactory: ViewControllerFactory {
   
   func loginViewController() -> UIViewController {
      let loginAPI: LoginAPI = LoginAPI(session: .shared)
      let loginViewController: LoginViewController = LoginViewController()
      let viewModel: LoginViewModel = LoginViewModel(api: loginAPI)
      loginViewController.viewModel = viewModel
      return loginViewController
   }
   
   func filmCollectionViewController() -> UIViewController {
      let filmCollectionAPI: FilmCollectionAPI = FilmCollectionAPI(session: .shared)
      let filmCollectionViewController: FilmCollectionViewController = FilmCollectionViewController()
      let viewModel: FilmCollectionViewModel = FilmCollectionViewModel(api: filmCollectionAPI)
      filmCollectionViewController.viewModel = viewModel
      return filmCollectionViewController
   }
   
   
   
}
