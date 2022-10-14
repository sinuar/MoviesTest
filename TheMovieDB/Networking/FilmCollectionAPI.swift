//
//  FilmCollectionAPI.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 14/10/22.
//

import Foundation

enum HTTPMethod: String {
   case GET
   case POST
}

struct FilmCollectionAPI {   
   let session: URLSession
     
     func load(_ endpoint: Endpoint, completion: @escaping (Result<FilmCollectionService, Error>) -> ()) {
         var request = endpoint.request
         
        request.httpMethod = HTTPMethod.GET.rawValue
        
        session.dataTask(with: request) { data, response, error in
             
           if let error: Error = error {
                 completion(.failure(error))
                 return
             }
             
           guard let data: Data = data else {
                 completion(.failure(APIError.noData))
                 return
             }
             
             do {
                let filmCollection: FilmCollectionService = try JSONDecoder().decode(FilmCollectionService.self, from: data)
                completion(.success(filmCollection))
                 
             } catch {
                 completion(.failure(APIError.parsingData))
             }
             
         }.resume()
     }
}
