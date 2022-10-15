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
      api.send(.login, userLoginData: loginData) { [weak self] (result: Result<LoginResponse, Error>) in
         switch result {
            case .success(let loginResponse):
               self?.state = .success
               print(loginResponse)
            case .failure(let error):
               let error = error as? APIError
               switch error {
                  case .internalServer:
                     self?.errorMessage = "Invalid username and/or password. You did not provide a valid login."
                  default:
                     self?.errorMessage = "Something went wrong"
               }
               self?.state = .failure
         }
      }
   }
}
