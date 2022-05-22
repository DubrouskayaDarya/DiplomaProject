//
//  Constants.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 21.04.22.
//

import Foundation
import UIKit

enum Constants {
    enum Segues {
        static let books = "booksSegue"
        static let myBook = "myBookSegue"
        static let favouriteToDetailBook = "favouriteToDetailBookSegue"
        static let bookToDetailBook = "bookToDetailBookSegue"
    }

    enum Storyboards {
        static let main = UIStoryboard(name: "Main", bundle: nil)
    }

    enum ViewControllers {
        static let mainTabBarController
            = Storyboards.main.instantiateViewController(withIdentifier: "MainTabBarController")
        static let loginViewController
            = Storyboards.main.instantiateViewController(withIdentifier: "LoginViewController")
        static let onboardingViewController
            = Storyboards.main.instantiateViewController(withIdentifier: "OnboardingViewController")
    }

    enum UserDefaultsKeys {
        static let isOnboardingFinishedKey = "isOnboardingFinishedKey"
    }

    enum CellIdentifiers {
        static let bookCell = "BookCellIdentifier"
    }
}
