////
////  PaperOnboarding.swift
////  DiplomaProject
////
////  Created by Дарья Дубровская on 9.05.22.
////
//
//import UIKit
//import PaperOnboarding
//
//class PaperOnboarding: UIView {
//
//     func viewDidLoad() {
////      super.viewDidLoad()
//
//      let onboarding = PaperOnboarding()
//      onboarding.dataSource = self
//      onboarding.translatesAutoresizingMaskIntoConstraints = false
//      view.addSubview(onboarding)
//
//      // add constraints
//      for attribute: NSLayoutAttribute in [.Left, .Right, .Top, .Bottom] {
//        let constraint = NSLayoutConstraint(item: onboarding,
//                                            attribute: attribute,
//                                            relatedBy: .Equal,
//                                            toItem: view,
//                                            attribute: attribute,
//                                            multiplier: 1,
//                                            constant: 0)
//        view.addConstraint(constraint)
//      }
//    }
//
//    func onboardingItem(at index: Int) -> OnboardingItemInfo {
//
//      return [
//        OnboardingItemInfo(informationImage: IMAGE,
//                                      title: "title",
//                                description: "description",
//                                   pageIcon: IMAGE,
//                                      color: UIColor.RANDOM,
//                                 titleColor: UIColor.RANDOM,
//                           descriptionColor: UIColor.RANDOM,
//                                  titleFont: UIFont.FONT,
//                            descriptionFont: UIFont.FONT),
//
//        OnboardingItemInfo(informationImage: IMAGE,
//                                       title: "title",
//                                 description: "description",
//                                    pageIcon: IMAGE,
//                                       color: UIColor.RANDOM,
//                                  titleColor: UIColor.RANDOM,
//                            descriptionColor: UIColor.RANDOM,
//                                   titleFont: UIFont.FONT,
//                             descriptionFont: UIFont.FONT),
//
//       OnboardingItemInfo(informationImage: IMAGE,
//                                    title: "title",
//                              description: "description",
//                                 pageIcon: IMAGE,
//                                    color: UIColor.RANDOM,
//                               titleColor: UIColor.RANDOM,
//                         descriptionColor: UIColor.RANDOM,
//                                titleFont: UIFont.FONT,
//                          descriptionFont: UIFont.FONT)
//        ][index]
//    }
//
//    func onboardingItemsCount() -> Int {
//       return 3
//     }
//    
//}
