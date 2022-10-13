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
      let parameters: [String: Any] = [
         "username": userLoginData.username ?? "",
         "password": userLoginData.password ?? "",
         "request_token": "cd6220fe99ad394fccc26ced47e1cca6b281799e"
      ]
      
      
   request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
   request.setValue("application/json", forHTTPHeaderField: "Accept")
   request.httpMethod = "POST"
   request.httpBody = parameters.percentEncoded()
      
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
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            completion(.success(loginResponse))
            return
         } catch {
            completion(.failure(APIError.parsingData))
         }
         
         
      }.resume()
   }
   
}

extension Dictionary {
  func percentEncoded() -> Data? {
    map { key, value in
      let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      return escapedKey + "=" + escapedValue
    }
    .joined(separator: "&")
    .data(using: .utf8)
  }
}

extension CharacterSet {
  static let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowed: CharacterSet = .urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
  }()
}

