//
//  FilmCollectionViewModel.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 14/10/22.
//

import Foundation

final class FilmCollectionViewModel {
   var api: FilmCollectionAPI
   @ViewModelState var state: APIState?
   var errorMessage: String?
   
   init(api: FilmCollectionAPI) {
      self.api = api
   }
   
   
   func requestFilms() {
      state = .loading
      api.load(.films) { result in
         switch result {
            case .success(let films):
               self.state = .success
               print(films)
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
}
