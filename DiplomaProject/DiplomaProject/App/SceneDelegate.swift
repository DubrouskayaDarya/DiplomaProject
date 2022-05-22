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

        let isOnboardingFinished =
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.isOnboardingFinishedKey)

        ref = Database.database().reference(withPath: "users")

        let user = Auth.auth().currentUser

        var initialViewController: UIViewController?

        if user == nil {
            initialViewController = isOnboardingFinished ?
            Constants.ViewControllers.loginViewController :
            Constants.ViewControllers.onboardingViewController
        } else {
            initialViewController = Constants.ViewControllers.mainTabBarController
        }

        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
    }
}
