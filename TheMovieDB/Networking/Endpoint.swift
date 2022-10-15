//
//  Endpoint.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation

enum Endpoint {
   static let baseURL = "https://api.themoviedb.org/3/"
   case login
   case films
}

extension Endpoint {
   var apiKey: String {
      Credentials.apiKey
   }
   var string: String {
      switch self {
         case .login:
            return "authentication/token/validate_with_login?api_key=\(apiKey)"
         case .films:
            return "trending/movie/week?api_key=\(apiKey)"
      }
   }
   
   var request: URLRequest {
      switch self {
         case .login, .films:
            let url: URL = URL(string: Endpoint.baseURL + string) ?? URL(fileURLWithPath: "")
            return URLRequest(url: url)
      }
   }
}
