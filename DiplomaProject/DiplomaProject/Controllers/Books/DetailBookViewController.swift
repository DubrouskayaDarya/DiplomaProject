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
    var book: Result!
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var authorLAbel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(String(describing: book))"
        
//        authorLAbel?.text = book.artistName
        descriptionLabel?.text = "New book for you"
        cityLabel?.text = "Minsk"
        priceLabel?.text = "free"

    }
    
    @IBAction func contactTouchUpInside(_ sender: Any) {
        let alertController = UIAlertController(title: "Phone", message: "You can call the owner", preferredStyle: .alert)
        let call = UIAlertAction(title: "Call", style: .default) { [weak self] _ in

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
    

}
