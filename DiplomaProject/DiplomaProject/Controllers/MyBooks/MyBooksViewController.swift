//
//  MyBooksViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 30.04.22.
//

import Firebase
import UIKit

class MyBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var ref: DatabaseReference!
    var myBooks = [MyBook]()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
       ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("myBooks")
        tableView.register(MyBooksTableViewCell.self, forCellReuseIdentifier: "MyBooksCell")
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // наблюдатель за значениями
//        ref.observe(.value) { [weak self] snapshot in
//            var myBooks = [MyBooks]()
//            for item in snapshot.children { // вытаскиваем все tasks
//                guard let snapshot = item as? DataSnapshot,
//                      let myBook = MyBooks(snapshot: snapshot) else { continue }
//                myBooks.append(myBook)
//            }
//            self?.myBooks = myBooks
//            self?.tableView.reloadData()
//        }
//    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // удаляем всех Observers
//        ref.removeAllObservers()
//    }

    // MARK: Private

//    private func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool) {
//        cell.accessoryType = isCompleted ? .checkmark : .none
//    }

    // MARK: UITableViewDelegate, UITableViewDataSource

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            7
//            myBooks.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyBooksCell", for: indexPath)
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white

//            let currentMyBook = myBooks[indexPath.row]
//            cell.textLabel?.text = currentMyBook.title
//            toggleCompletion(cell, isCompleted: currentMyBook.completed)
            return cell
        }

        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            true
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle != .delete { return }
            let myBook = myBooks[indexPath.row]
            myBook.ref?.removeValue()
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

