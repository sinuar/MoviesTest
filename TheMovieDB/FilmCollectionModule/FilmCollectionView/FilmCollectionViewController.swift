//
//  FilmCollectionViewController.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 13/10/22.
//

import UIKit

final class FilmCollectionViewController: UIViewController {
//   var viewModel
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      setupView()
   }
   
   private func setupView() {
      view.backgroundColor = .blue
   }
}
