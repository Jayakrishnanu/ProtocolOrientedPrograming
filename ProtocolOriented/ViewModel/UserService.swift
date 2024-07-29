//
//  UserService.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

protocol UserService {
    func fetchUsers(completionHandler: @escaping(Result<User, NetworkError>) -> Void)
}
