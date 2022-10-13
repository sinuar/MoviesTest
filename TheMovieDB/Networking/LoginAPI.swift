//
//  LoginAPI.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import Foundation

struct LoginAPI {
   let session: URLSession
   
   func send(_ endpoint: Endpoint, userLoginData: UserLoginData, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
      var request = endpoint.request
      
      request.httpMethod = "POST"
      let parameters: [String: String] = [
         "username": userLoginData.username ?? "",
         "password": userLoginData.password ?? "",
         "request_token": "f5152eed166bb61e1f030e531f47af478f650464"
      ]
      
      do {
         let body: Data = try JSONSerialization.data(withJSONObject: parameters)
         request.httpBody = body
      } catch {
         print("some error")
      }
      
      session.dataTask(with: request) { data, response, error in
         
         if let error = error {
            debugPrint("error", error)
            completion(.failure(error))
            return
         }
         
         guard let data = data else {
            completion(.failure(APIError.noData))
            return
         }
         guard let response = response as? HTTPURLResponse else {
            completion(.failure(APIError.response))
            return
         }
         guard (200 ... 299) ~= response.statusCode else {
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            completion(.failure(APIError.internalServer))
            return
         }
         
         do {
            let postTweet = try JSONDecoder().decode(LoginResponse.self, from: data)
            completion(.success(postTweet))
         } catch {
            completion(.failure(APIError.parsingData))
         }
      }.resume()
   }
}
