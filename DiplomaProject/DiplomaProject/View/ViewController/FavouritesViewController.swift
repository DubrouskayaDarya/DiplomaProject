//
//  FavouritesViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 7.05.22.
//

import Firebase
import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var user: User!
    var ref: DatabaseReference!
    var books: [Book] = []
    var favouriteBooks = Set<String>()

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
        if let detailBookViewController = segue.destination as? DetailBookViewController, let index = sender as? Book {
            detailBookViewController.book = index
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            var books = [Book]()
            for user in snapshot.children {
                guard let userSnapshot = user as? DataSnapshot else { continue }

                // favourite
                let favouriteSnapshot = userSnapshot.childSnapshot(forPath: "favouriteBooks")
                if let favouriteBooks = favouriteSnapshot.value as? [String] {
                    self.favouriteBooks = Set(favouriteBooks.map { $0 })
                } else {
                    self.favouriteBooks = Set<String>()
                }

                // books
                let booksSnapshot = userSnapshot.childSnapshot(forPath: "books")
                for bookSnapshot in booksSnapshot.children {
                    guard let bookSnapshot = bookSnapshot as? DataSnapshot,
                        let book = Book(snapshot: bookSnapshot) else { continue }
                    books.append(book)
                }
            }

            self.books = books.filter { self.favouriteBooks.contains($0.ref?.key ?? "") }
            self.tableView.reloadData()
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: Constants.Segues.favouriteToDetailBook, sender: book)
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
