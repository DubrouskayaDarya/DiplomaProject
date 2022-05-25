//
//  MyBooksViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 30.04.22.
//

import Firebase
import UIKit
import PKHUD

class MyBooksViewController: BaseBooksViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("books")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            var books = [Book]()
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                    let book = Book(snapshot: snapshot) else { continue }
                books.append(book)
            }
            self?.books = books
            self?.tableView.reloadData()
        }
    }

    // MARK: UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle != .delete { return }
        let book = books[indexPath.row]
        book.ref?.removeValue()

        // Create a reference to the file to delete
        HUD.show(.progress)
        let ref = Storage.storage().reference().child("images").child(book.ref!.key!)
        HUD.flash(.success, delay: 0.5)
        // Delete the file
        ref.delete { error in
            if let error = error {
                print(error)
            } else {
                print("File deleted successfully")
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: Constants.Segues.myBook, sender: book)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myBookViewController = segue.destination as? MyBookViewController, let book = sender as? Book {
            myBookViewController.book = book
        }
    }
}
