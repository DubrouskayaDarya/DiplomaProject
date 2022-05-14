//
//  DetailBookViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 1.05.22.
//

import Firebase
import UIKit
import Kingfisher

class DetailBookViewController: UIViewController {

    var user: User!
    var book: Book!
    var ref: DatabaseReference!
    var favouriteBooks = Set<String>()

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isFavouriteSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIWithData()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid))
    }

    override func viewWillAppear(_ animated: Bool) {
        ref.child("favouriteBooks").observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            var favouriteBooks = Set<String>()
            for child in snapshot.children {
                let snap = child as! DataSnapshot // trmove !
                let id = snap.value as! String
                favouriteBooks.insert(id)
            }
            self.favouriteBooks = favouriteBooks
            self.isFavouriteSwitch.isOn = self.favouriteBooks.contains(self.book.ref?.key ?? "")
        }
    }
    
    // отпишись в дисапере

    @IBAction func contactTouchUpInside(_ sender: Any) {

        let alertController = UIAlertController(title: "Phone", message: "You can call the owner of the book", preferredStyle: .alert)

        let call = UIAlertAction(title: "Call", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let url = URL(string: "tel://\(self.book.phone)")!
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(call)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }

    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        let id = self.book.ref?.key ?? ""
        if sender.isOn {
            // add favorite
            favouriteBooks.insert(id)
            self.ref.child("favouriteBooks").setValue(Array(favouriteBooks))
        } else {
            // remove favorite
            favouriteBooks.remove(id)
            self.ref.child("favouriteBooks").setValue(Array(favouriteBooks))
        }
    }

    @IBAction func shareButtonTouchUpInside(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: ["Check my app at www.myapp.example.com"], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view

        self.present(vc, animated: true, completion: nil)
    }

    private func setupUIWithData() {
        titleLabel?.text = book.title
        authorLabel?.text = book.author
        descriptionLabel?.text = book.description
        cityLabel?.text = book.city
        priceLabel?.text = book.price
        let url = URL(string: book.imageUrl)
        bookImageView.kf.setImage(with: url)
    }
}
