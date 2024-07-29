//
//  RootViewController.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import UIKit

class RootViewController: UIViewController, RootViewModelOutput {
    
    

    private var viewModel: RootViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
    }
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showMainApp() {
        let mainViewController = MainViewController()
        if let window = UIApplication.shared.keyWindow {
            let navigationVC = UINavigationController(rootViewController: mainViewController)
        }
    }
    
    func showLogin() {
        let loginViewController = LoginViewController()
        if let window = UIApplication.shared.keyWindow {
            let navigationVC = UINavigationController(rootViewController: loginViewController)
            window.rootViewController = navigationVC
        }
    }
    
    
}
