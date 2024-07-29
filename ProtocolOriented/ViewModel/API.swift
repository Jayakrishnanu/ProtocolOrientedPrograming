//
//  API.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

enum NetworkError: Error {
    case failedNetwork
}

class APIManager: UserService {
    
//    static let shared = APIManager()
//    private init() { }
    
    func fetchUsers(completionHandler: @escaping(Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Failed with the url")}
        _ = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completionHandler(.failure(.failedNetwork))
            }
            if let data = data {
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    if let  users  = try? decoder.decode([User].self, from: data) {
                        completionHandler(.success(users.last!))
                    } else {
                        completionHandler(.failure(.failedNetwork))
                    }
                }
               
            }
        }.resume()
    }
}
