//
//  LoginStorageServiceImpl.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

class LoginStorageServiceImpl: LoginStorageService {
    
    private let storage = UserDefaults.standard
    
    var userAccessToken: String {
        return "ACCESS_TOKEN"
    }
    
    func setUserAccessToken(token: String) {
        storage.set(token, forKey: userAccessToken)
    }
    
    func getUserAccessToken() -> String? {
        return storage.string(forKey: userAccessToken)
    }
    
    
}
