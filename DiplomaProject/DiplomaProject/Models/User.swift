//
//  User.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 20.04.22.
//

import Firebase
import Foundation

struct User {
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }

    let uid: String
    let email: String
}
