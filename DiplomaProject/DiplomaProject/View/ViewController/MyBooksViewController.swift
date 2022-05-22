//
//  MyBooksViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 30.04.22.
//

import Firebase
import UIKit
import PKHUD

class MyBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var user: User!
    var ref: DatabaseReference!
    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("books")
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil),
                           forCellReuseIdentifier: Constants.CellIdentifiers.bookCell)
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }

    // MARK: UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.bookCell,
                                                       for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }

        let book = books[indexPath.row]
        cell.configure(with: book)

        return cell
    }

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

    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
}
