//
//  LoginModel.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation

struct LoginResponse: Codable {
   let success: Bool
   let expiresAt: String?
   let token: String?
   
   enum CodingKeys: String, CodingKey {
      case success = "success"
      case expiresAt = "expires_at"
      case token = "request_token"
   }
   
}

enum APIError: Error {
     case noData
     case response
     case parsingData
     case internalServer
}

struct UserLoginData {
   var username: String? = nil
   var password: String? = nil
}

enum TextFieldTag: Int {
   case username = 0
   case password = 1
}
