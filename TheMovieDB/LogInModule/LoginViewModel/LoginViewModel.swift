//
//  LoginViewModel.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation

final class LoginViewModel {
   var userLoginData: UserLoginData?
   var api: LoginAPI
   @ViewModelState var state: APIState?
   var errorMessage: String?
   
   init(api: LoginAPI) {
      self.api = api
   }
   
   
   func requestLoginAccess() {
      state = .loading
      guard let loginData: UserLoginData = userLoginData else { return }
      api.send(.login, userLoginData: loginData) { result in
         switch result {
            case .success(let tweets):
               self.state = .success
               print(tweets)
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
