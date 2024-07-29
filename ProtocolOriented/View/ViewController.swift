//
//  ViewController.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import UIKit

class ViewController: UIViewController, UserViewModelOutput {
    
    let viewModel: UserViewModel
    
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        setupView()
        fetchUser()
    }
    
    func setupView() {
        view.addSubview(userLabel)
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            userLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userLabel.heightAnchor.constraint(equalToConstant: 60),
            userLabel.widthAnchor.constraint(equalToConstant: 200),
            userLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 60),
            emailLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 10)

        ])
    }

    func updateView(user: String, email: String) {
        self.userLabel.text = user
        self.emailLabel.text = email
    }
    
    func fetchUser() {
//        APIManager.shared.fetchUsers { [weak self] result in
//            switch result {
//            case .success(let users):
//                let user = users.first ?? User(id: 0, name: "Failed", email: "")
//                self?.userLabel.text = user.name
//                self?.emailLabel.text = user.email
//            case .failure(let error):
//                print("Error")
//            }
//        }
        viewModel.fetchUsers()
    }
}

