//
//  APIError.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 14/10/22.
//

import Foundation

enum APIError: Error {
     case noData
     case response
     case parsingData
     case internalServer
}
