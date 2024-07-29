//
//  API.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case failedURL
    case failedData
    case failedResponse
    case failedStatusCode
}

class APIManager: UserService {
    
    //    static let shared = APIManager()
    //    private init() { }
    
    func fetchUsers(completion: @escaping(Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(.failedURL))
            return
        }
        
       URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.failedResponse))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completion(.failure(.failedStatusCode))
            }
            if let data = data {
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    if let  users  = try? decoder.decode([User].self, from: data) {
                        completion(.success(users.last!))
                    } else {
                        completion(.failure(.failedData))
                    }
                }
                
            }
        }.resume()
    }
    
    func fetchUsersAsync() async throws -> Result<[User], NetworkError> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return .failure(.failedURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return .failure(.failedStatusCode)
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let decoder = JSONDecoder()
            let decodeUser = try decoder.decode([User].self, from: data)
            return .success(decodeUser)
        } catch {
            return .failure(.failedData)
        }
    }
    
    func fetchUserCombine() -> AnyPublisher<[User], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        return URLSession.shared.dataTaskPublisher(for: url!)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
