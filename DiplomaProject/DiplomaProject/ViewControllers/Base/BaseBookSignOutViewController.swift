//
//  BaseBookSignOutViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 23.05.22.
//

import UIKit
import Firebase

class BaseBookSignOutViewController: UIViewController {
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Sign out",
                                                message: "Are you sure you want to sign out?",
                                                preferredStyle: .alert)

        let signOut = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            try? Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(signOut)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}
