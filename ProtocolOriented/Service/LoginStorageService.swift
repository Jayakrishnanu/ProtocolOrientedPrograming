//
//  LoginStorageService.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

protocol LoginStorageService {
    var userAccessToken: String { get }
    func setUserAccessToken(token: String)
    func getUserAccessToken() -> String?
}
