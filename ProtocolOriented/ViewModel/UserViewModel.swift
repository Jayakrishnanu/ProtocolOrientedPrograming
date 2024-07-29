//
//  UserViewModel.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

class UserViewModel {
    
    private let userService: UserService
    weak var output: UserViewModelOutput?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func fetchUsers() {
        userService.fetchUsers { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.updateView(user: user.name, email: user.email )
            case .failure(let error):
                print(error.localizedDescription)
                self?.output?.updateView(user: "No user", email: "" )
            }
        }
    }
    
    
    
}
