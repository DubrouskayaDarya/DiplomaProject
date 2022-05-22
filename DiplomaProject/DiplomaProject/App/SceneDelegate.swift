//
//  SceneDelegate.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 18.04.22.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var ref: DatabaseReference!
    
    let isOnboardingFinishedKey = "isOnboardingFinishedKey"

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let isOnboardingFinished = UserDefaults.standard.bool(forKey: isOnboardingFinishedKey)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        ref = Database.database().reference(withPath: "users")

        let user = Auth.auth().currentUser

        var initialViewController: UIViewController?

        if user == nil {
            initialViewController = isOnboardingFinished ?
            sb.instantiateViewController(withIdentifier: "LoginViewController") :
            sb.instantiateViewController(withIdentifier: "OnboardingViewController")
            
        } else {
            initialViewController = sb.instantiateViewController(withIdentifier: "MainTabBarController")
        }

        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
    }
}
