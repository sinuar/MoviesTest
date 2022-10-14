//
//  FilmCollectionViewModel.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 14/10/22.
//

import Foundation

final class FilmCollectionViewModel {
   var api: FilmCollectionAPI
   var filmList: [FilmList] = []
   @ViewModelState var state: APIState?
   var errorMessage: String?
   
   init(api: FilmCollectionAPI) {
      self.api = api
   }
   
   func requestFilms() {
      state = .loading
      api.load(.films) { (result: Result<FilmCollectionService, Error>) in
         switch result {
            case .success(let films):
               guard let filmsResults: [FilmCollectionResult] = films.results else { return }
               self.fillList(with: filmsResults)
               self.state = .success
            case .failure(let error):
               let error = error as? APIError
               switch error {
                  case .internalServer:
                     print("error")
                  default:
                     self.errorMessage = "Something went wrong"
                     fatalError()
               }
               self.state = .failure

         }
      }
   }
   
   private func fillList(with films: [FilmCollectionResult]) {
      filmList = films.map { film in
         FilmList(from: film)
      }
   }
}
