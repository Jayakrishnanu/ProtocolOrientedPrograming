//
//  SceneDelegate.swift
//  ProtocolOriented
//
//  Created by Jayakrishnan u on 7/29/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window  = UIWindow(windowScene: scene)
        // for login VC
        let loginStorageService: LoginStorageService = LoginStorageServiceImpl()
        let viewModel  = RootViewModel(loginStorageService: loginStorageService)
        // For api call
        let service: UserService = APIManager()
        let userModel = UserViewModel(userService: service)
//        window?.rootViewController = UINavigationController(rootViewController: RootViewController(viewModel: viewModel))
        window?.rootViewController = UINavigationController(rootViewController: ViewController(viewModel: userModel))
        window?.makeKeyAndVisible()
    }

    
}

