//
//  OnboardingViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 14.05.22.
//

import UIKit
import PaperOnboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource {

    var window: UIWindow?

    @IBOutlet weak var onboardingView: OnboardingView!

    @IBOutlet weak var skipButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let onboarding = PaperOnboarding()
        onboardingView.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
    }

    func onboardingItemsCount() -> Int {
        return 3
    }

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(displayP3Red: 217 / 255, green: 72 / 255, blue: 89 / 255, alpha: 1)
        let backgroundColorTwo = UIColor(displayP3Red: 106 / 255, green: 166 / 255, blue: 211 / 255, alpha: 1)
        let backgroundColorThree = UIColor(displayP3Red: 204 / 255, green: 153 / 255, blue: 255 / 255, alpha: 1)

        let bookImage = UIImage(systemName: "books.vertical.circle") as UIImage?
        let myBookImage = UIImage(systemName: "person.fill") as UIImage?
        let favoritesImage = UIImage(systemName: "bookmark.fill") as UIImage?

        return [
            OnboardingItemInfo(informationImage: bookImage!,
                title: "Books",
                description: """
                            All users' book announcements are displayed here.
                            When you click on a book, you can view the detailed information of this book,
                            share the book, call the owner of this book, or add the book to your favorites
                            """,
                pageIcon: bookImage!,
                color: backgroundColorOne,
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: UIFont(name: "AvenirNext-Bold", size: 28)!,
                descriptionFont: UIFont(name: "AvenirNext-Regular", size: 22)!),

            OnboardingItemInfo(informationImage: myBookImage!,
                title: "My books",
                description: """
                            Only your added books are displayed here.
                            On this screen, you can also add your book, and when you click on an already added book,
                            you can view the details of the added book and edit your listing
                            """,
                pageIcon: myBookImage!,
                color: backgroundColorTwo,
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: UIFont(name: "AvenirNext-Bold", size: 28)!,
                descriptionFont: UIFont(name: "AvenirNext-Regular", size: 22)!),

            OnboardingItemInfo(informationImage: favoritesImage!,
                title: "Favorites",
                description: """
                            All books that you have added to your favorites are displayed here.
                            When you click on a book, you can view detailed information about that book,
                            share the book, call the owner of that book, or remove the book from your favorites.
                            """,
                pageIcon: favoritesImage!,
                color: backgroundColorThree,
                titleColor: UIColor.white,
                descriptionColor: UIColor.white,
                titleFont: UIFont(name: "AvenirNext-Bold", size: 28)!,
                descriptionFont: UIFont(name: "AvenirNext-Regular", size: 22)!)

        ][index]
    }

    @IBAction func skipAction(_ sender: Any) {
        view.window?.rootViewController = Constants.ViewControllers.loginViewController
        UserDefaults.standard.set(true, forKey: Constants.UserDefaultsKeys.isOnboardingFinishedKey)
    }
}
