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
}

extension Endpoint {
   var apiKey: String {
      "a2540b1797d974a24f35f1e2381611dc"
   }
   var string: String {
      switch self {
         case .login:
            return "authentication/token/validate_with_login?api_key=\(apiKey)"
      }
   }
   
   var request: URLRequest {
      switch self {
         case .login:
            let url: URL = URL(string: Endpoint.baseURL) ?? URL(fileURLWithPath: "")
            return URLRequest(url: url)
      }
   }
}
