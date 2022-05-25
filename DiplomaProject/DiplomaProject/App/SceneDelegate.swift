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

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let isApplicationWasLaunchedBefore =
        UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.appicationWasLaunchedKey)
        UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKeys.appicationWasLaunchedKey)

        if !isApplicationWasLaunchedBefore {
            try? Auth.auth().signOut()
        }

        ref = Database.database().reference(withPath: "users")

        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            window.rootViewController = user == nil ?
             self.startViewController :
            Constants.ViewControllers.mainTabBarController

            window.makeKeyAndVisible()
        }
    }

    var startViewController: UIViewController {
        let isOnboardingFinished =
        UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.isOnboardingFinishedKey)
        return isOnboardingFinished ?
        Constants.ViewControllers.loginViewController :
        Constants.ViewControllers.onboardingViewController
    }
}
