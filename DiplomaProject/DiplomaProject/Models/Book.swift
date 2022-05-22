//
//  Book.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 29.04.22.
//

import Firebase
import Foundation
import UIKit

struct Book {
    internal init(title: String, userId: String, author: String, description: String?, city: String, price: String?, phone: String, imageUrl: String, ref: DatabaseReference?) {
        self.title = title
        self.userId = userId
        self.author = author
        self.description = description
        self.city = city
        self.price = price
        self.phone = phone
        self.imageUrl = imageUrl
        self.ref = ref
    }
    
    var title: String
    let userId: String
    let author: String
    let description: String?
    let city: String
    let price: String?
    let phone: String
    var imageUrl: String
    let ref: DatabaseReference?

    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let title = snapshotValue[Constants.titleKey] as? String,
              let userId = snapshotValue[Constants.userIdKey] as? String,
              let author = snapshotValue[Constants.authorKey] as? String,
              let description = snapshotValue[Constants.descriptionKey] as? String,
              let city = snapshotValue[Constants.cityKey] as? String,
              let price = snapshotValue[Constants.priceKey] as? String,
              let phone = snapshotValue[Constants.phoneKey] as? String,
              let imageUrl = snapshotValue[Constants.imageUrlKey] as? String else { return nil }
        self.title = title
        self.userId = userId
        self.author = author
        self.description = description
        self.city = city
        self.price = price
        self.phone = phone
        self.imageUrl = imageUrl
        
        ref = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        [Constants.titleKey: title, Constants.userIdKey: userId, Constants.authorKey: author, Constants.descriptionKey: description ?? "", Constants.cityKey: city, Constants.priceKey: price ?? "", Constants.phoneKey: phone, Constants.imageUrlKey: imageUrl]
    }

    enum Constants {
        static let titleKey = "title"
        static let userIdKey = "userId"
        static let authorKey = "author"
        static let descriptionKey = "description"
        static let cityKey = "city"
        static let priceKey = "price"
        static let phoneKey = "phone"
        static let imageUrlKey = "imageUrl"
    }
}

