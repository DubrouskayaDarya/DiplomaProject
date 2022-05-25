//
//  BaseBooksViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 22.05.22.
//

import Firebase
import UIKit

class BaseBooksViewController: BaseBookSignOutViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
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
}
