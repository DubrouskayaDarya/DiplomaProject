//
//  FavouritesViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 7.05.22.
//

import Firebase
import UIKit

class FavouritesViewController: BaseBooksViewController {

    var favouriteBooks = Set<String>()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            guard let self = self else { return }
            var books = [Book]()
            for user in snapshot.children {
                guard let userSnapshot = user as? DataSnapshot else { continue }

                // favourite
                let favouriteSnapshot = userSnapshot.childSnapshot(forPath: "favouriteBooks")
                if userSnapshot.key == self.user.uid {
                    if let favouriteBooks = favouriteSnapshot.value as? [String] {
                        self.favouriteBooks = Set(favouriteBooks.map { $0 })
                    } else {
                        self.favouriteBooks = Set<String>()
                    }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailBookViewController = segue.destination as? DetailBookViewController, let index = sender as? Book {
            detailBookViewController.book = index
        }
    }

    // MARK: UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: Constants.Segues.favouriteToDetailBook, sender: book)
    }
}
