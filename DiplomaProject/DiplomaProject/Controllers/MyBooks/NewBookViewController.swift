//
//  NewBookViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 5.05.22.
//

import Firebase
import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

class NewBookViewController: UIViewController {
    
    var user: User!
    var ref: DatabaseReference!
    var newBooks = [MyBook]()
    var imagePicker = UIImagePickerController()
    private weak var delegate: ImagePickerDelegate?


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
       ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("myBooks")
        
        imagePicker.delegate = self
    }
    
    @IBAction func addImageTouchUpInside(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
  
    @IBAction func saveBookTouchUpInside(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.delegate?.didSelect(image: image)
    }

}

extension NewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.imagePicker(picker, didSelect: nil)
        }
        self.imagePicker(picker, didSelect: image)
    }
}
