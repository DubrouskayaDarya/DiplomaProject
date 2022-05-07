//
//  JobsTableViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 21.04.22.
//

import Firebase
import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var signOutButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    private var welcome: Welcome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
        fetchData()
//        tableView.register(BooksTableViewCell.self, forCellReuseIdentifier: "bookCell")
    }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailBookViewController,
                let user = sender as? User {
                destination.user = user
            }
            if let vc = segue.destination as? DetailBookViewController,
            let index = (sender as? IndexPath)?.row {
            let book = welcome?.feed.results[index]
            vc.book = book
        }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return welcome?.feed.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BooksTableViewCell
        if let result = welcome?.feed.results[indexPath.row] {
            cell.configure(with: result)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let book = welcome?.feed.results[indexPath.row]
            performSegue(withIdentifier: "detailBooksSegue", sender: book)
        }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return tru
     }
     */
    
    func fetchData () {
        guard let url = ApiBooks.remoteBooksUrl else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self, let data = data else { return }
            do {
                self.welcome = try JSONDecoder().decode(Welcome.self, from: data)
                print(self.welcome)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
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

