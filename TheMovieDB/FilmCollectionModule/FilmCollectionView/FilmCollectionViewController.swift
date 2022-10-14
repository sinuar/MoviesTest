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
      handleViewModelState()
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
         filmCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
         filmCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
         filmCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8),
         filmCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
      ])
      filmCollection.backgroundColor = .black
      filmCollection.delegate = self
      filmCollection.dataSource = self
      filmCollection.register(FilmCollectionCell.self, forCellWithReuseIdentifier: FilmCollectionCell.reuseIdentifier)
      
   }
   
   private func guaranteeMainThread(_ work: @escaping () -> Void) {
      if Thread.isMainThread {
         work()
      } else {
         DispatchQueue.main.async(execute: work)
      }
   }
   
   private func handleViewModelState() {
      viewModel?.$state.observer = { [weak self] state in
         guard let filmsState: APIState = state else { return }
         self?.guaranteeMainThread {
            switch filmsState {
               case .loading:
                  self?.view.showLoader()
               case .success:
                  self?.filmCollection.reloadData()
                  self?.view.removeLoader()
               case .failure:
                  self?.view.removeLoader()
                  // TODO: Show alert
                  print("failure")
            }
         }
      }
   }
}

extension FilmCollectionViewController: UICollectionViewDelegate {}

extension FilmCollectionViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel?.filmList.count ?? .zero
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionCell.reuseIdentifier, for: indexPath)
      guard let film: FilmList = viewModel?.filmList[indexPath.item] else { return UICollectionViewCell() }
      (cell as? FilmCollectionCell)?.setup(with: film)
      
      
      return cell
   }
}

extension FilmCollectionViewController: UICollectionViewDelegateFlowLayout {}
