//
//  FilmCollectionModel.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 14/10/22.
//

import Foundation

struct FilmCollection: Codable {
   let page: Int?
   let results: [FilmCollectionResult]?
}

struct FilmCollectionResult: Codable {
   let poster: String?
   let title: String
   let releaseDate: String
   let rating: Double
   let review: String
   
   enum CodingKeys: String, CodingKey {
      case poster = "poster_path"
      case title = "original_title"
      case releaseDate = "release_date"
      case rating = "popularity"
      case review = "overview"
      
   }
   
}
