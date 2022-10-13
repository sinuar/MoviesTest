//
//  LoginModel.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation

struct LoginResponse: Decodable {
   let isSuccessful: Bool
   let validToken: String
}

enum APIError: Error {
     case noData
     case response
     case parsingData
     case internalServer
}

struct UserLoginData {
   let username: String
   let password: String
}
