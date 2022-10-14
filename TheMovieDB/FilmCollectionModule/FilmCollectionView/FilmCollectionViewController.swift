//
//  FilmCollectionViewController.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 13/10/22.
//

import UIKit

final class FilmCollectionViewController: UIViewController {
   // MARK :- PROPERTIES
   @UsesLayout private var filmCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

   var viewModel: FilmCollectionViewModel?
   
   override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
      collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
      collectionViewLayout.scrollDirection = .vertical
      collectionViewLayout.minimumLineSpacing = 8
      collectionViewLayout.minimumInteritemSpacing = 8
      filmCollection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      viewModel?.requestFilms()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      setupView()
      setupNavigationBar()
      setupCollectionView()
   }
   
   private func setupView() {
      view.backgroundColor = .black
   }
   
   private func setupNavigationBar() {
      navigationController?.navigationBar.prefersLargeTitles = false

      let appearance = UINavigationBarAppearance()
      appearance.backgroundColor = .darkGray
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToProfile))
      
      
      navigationItem.setHidesBackButton(true, animated: true)
      navigationController?.navigationBar.tintColor = .lightGray
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.compactAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = appearance
      self.title = "Films"
   }
   
   @objc private func goToProfile() {
      print("profile")
   }
   
   private func setupCollectionView() {
      view.addSubview(filmCollection)
      NSLayoutConstraint.activate([
         filmCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
         filmCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
         filmCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
         filmCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
      ])
      filmCollection.backgroundColor = .red
      filmCollection.delegate = self
      filmCollection.dataSource = self
      filmCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
      
   }
   
}

extension FilmCollectionViewController: UICollectionViewDelegate {
   
}

extension FilmCollectionViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      2
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      cell.backgroundColor = .systemOrange
      return cell
   }
   
   
}

extension FilmCollectionViewController: UICollectionViewDelegateFlowLayout {
   
}
