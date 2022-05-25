//
//  JobsTableViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 21.04.22.
//

import Firebase
import UIKit

class BooksViewController: BaseBooksViewController {

    @IBOutlet var signOutButton: UIBarButtonItem!

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

    // MARK: UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: Constants.Segues.bookToDetailBook, sender: book)
    }
}
