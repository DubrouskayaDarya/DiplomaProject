//
//  LoginViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 21.04.22.
//

import Firebase
import UIKit
import PKHUD

class LoginViewController: UIViewController {

    var ref: DatabaseReference!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warnLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(withPath: "users")

        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    @IBAction func loginTappid(_ sender: UIButton) {
        // проверяем все поля
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            // показываем уникальный error
            displayWarningLabel(withText: "Data entered incorrectly \nEnter your email and password and click Sign in")
            return
        }

        // логинемся
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let _ = error {
                self?.displayWarningLabel(withText: "Error ocured \nEmail or password entered incorrectly")
            } else if let _ = user {
                // переходим на новый экран
                HUD.show(.progress)
                HUD.hide(afterDelay: 1) { success in
                    self?.performSegue(withIdentifier: Constants.Segues.books, sender: nil)
                }
                return
            } else {
                self?.displayWarningLabel(withText: "No such user \nCheck the entered data")
            }
        }
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        // проверяем все поля
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Data entered incorrectly \nEnter your email and password and click Sign up")
            return
        }

        // createUser
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                self?.displayWarningLabel(withText: "Registration was incorrect\n\(error.localizedDescription)")
            } else {
                HUD.show(.progress)
                guard let user = user else { return }
                let userRef = self?.ref.child(user.user.uid)
                userRef?.setValue(["email": user.user.email])
                HUD.flash(.success, delay: 0.5){ success in
                    self?.performSegue(withIdentifier: Constants.Segues.books, sender: nil)
                }
            }
        }
    }

    // MARK: Private

    private func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 8,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut, // плавно появляется и плавно исчезает
            animations: { [weak self] in
                self?.warnLabel.alpha = 1 }) { [weak self] _ in
            self?.warnLabel.alpha = 0
        }
    }

    @objc func kbDidShow(notification: Notification) {
        self.view.frame.origin.y = 0
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= (keyboardSize.height / 2)
        }
    }

    @objc func kbDidHide() {
        self.view.frame.origin.y = 0
    }
}



