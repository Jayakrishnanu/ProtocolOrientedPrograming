//
//  UserViewModelOutput.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import Foundation

protocol UserViewModelOutput: AnyObject {
    func updateView(user: String, email: String)
}
