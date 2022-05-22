//
//  BaseBooksViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 22.05.22.
//

import Firebase
import UIKit

class BaseBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User!
    var ref: DatabaseReference!
    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users")
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil),
                           forCellReuseIdentifier: Constants.CellIdentifiers.bookCell)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailBookViewController = segue.destination as? DetailBookViewController,
            let index = sender as? Book {
            detailBookViewController.book = index
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            var books = [Book]()
            for users in snapshot.children {
                guard let snapshot = users as? DataSnapshot else { continue }

                for userChildren in snapshot.children {
                    guard let snapshot = userChildren as? DataSnapshot else { continue }

                    for item in snapshot.children {
                        guard let snapshot = item as? DataSnapshot,
                            let book = Book(snapshot: snapshot) else { continue }
                        books.append(book)
                    }
                }
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

        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white

        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: Constants.Segues.bookToDetailBook, sender: book)
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
