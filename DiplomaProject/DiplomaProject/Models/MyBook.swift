//
//  Recipes.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 29.04.22.
//

import Firebase
import Foundation

struct MyBook {
    
    // MARK: Internal

    let title: String
    let userId: String
    let author: String
    let description: String?
    let city: String
    let price: String?
    let ref: DatabaseReference?

    init(title: String, userId: String, author: String, description: String, city: String, price: String) {
        self.title = title
        self.userId = userId
        self.author = author
        self.description = description
        self.city = city
        self.price = price
        self.ref = nil
    }

    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let title = snapshotValue[Constants.titleKey] as? String,
              let userId = snapshotValue[Constants.userIdKey] as? String,
              let author = snapshotValue[Constants.authorKey] as? String,
              let description = snapshotValue[Constants.descriptionKey] as? String,
              let city = snapshotValue[Constants.cityKey] as? String,
              let price = snapshotValue[Constants.priceKey] as? String else { return nil }
        self.title = title
        self.userId = userId
        self.author = author
        self.description = description
        self.city = city
        self.price = price
        ref = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        [Constants.titleKey: title, Constants.userIdKey: userId, Constants.authorKey: author, Constants.descriptionKey: description, Constants.cityKey: city, Constants.priceKey: price ?? ""]
    }

    private enum Constants {
        static let titleKey = "title"
        static let userIdKey = "userId"
        static let authorKey = "author"
        static let descriptionKey = "description"
        static let cityKey = "city"
        static let priceKey = "price"
    }
}

