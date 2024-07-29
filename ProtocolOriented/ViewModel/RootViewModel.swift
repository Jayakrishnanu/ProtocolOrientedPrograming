//
//  RootViewModel.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

class RootViewModel {
    private let loginStorageService: LoginStorageService
    weak var output: RootViewModelOutput?
    
    init(loginStorageService: LoginStorageService) {
        self.loginStorageService = loginStorageService
    }
    
    func checkLogin() {
        if let accessToken = loginStorageService.getUserAccessToken(), !accessToken.isEmpty {
            output?.showMainApp()
        } else {
            output?.showLogin()
        }
    }
}
