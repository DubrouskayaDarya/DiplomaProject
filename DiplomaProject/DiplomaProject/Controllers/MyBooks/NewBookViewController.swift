//
//  NewBookViewController.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 5.05.22.
//

import Firebase
import UIKit
import FirebaseCore
import FirebaseStorage

class NewBookViewController: UIViewController {

    var user: User!
    var ref: DatabaseReference!
    var newBooks = [Book]()
    var imagePicker: ImagePicker!

    @IBOutlet weak var imageBookView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
//        imageBookView.addText("No Image Selected")
        saveButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        authorTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        descriptionTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        cityTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        priceTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
       }
    
    @IBAction func addImageTouchUpInside(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        }
  
    @IBAction func saveBookTouchUpInside(_ sender: Any) {
        
        guard let image = imageBookView.image else {
            assertionFailure("Image was not selected")
            return
        }
        upload(image: image, currentBookId: user.uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let url):
                let book = Book(title: self.titleTextField.text ?? "",
                                userId: self.user.uid,
                                author: self.authorTextField.text ?? "",
                                description: self.descriptionTextField.text ?? "",
                                city: self.cityTextField.text ?? "",
                                price: self.priceTextField.text ?? "",
                                phone: self.phoneTextField.text ?? "",
                                imageUrl: url.absoluteString,
                                ref: self.ref)
                
                self.ref.child("users").child(self.user.uid).child("books").childByAutoId().setValue(book.convertToDictionary())
            case .failure(let error):
                assertionFailure("Can't upload image to firebase: \(error)")
            }
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        imageBookView.removeAll()
    }
    
    func upload (image: UIImage, currentBookId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("images").child(currentBookId)
        guard let imageData = imageBookView.image?.jpegData(compressionQuality: 0.4) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "images/jpeg"
        
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
//    var isTitleNotEmpty = false {
//        didSet { changeButtonStateIfNeeded() }
//    }
//    var isAuthorNotEmpty = false {
//        didSet { changeButtonStateIfNeeded() }
//    }
//    var isDescriptionNotEmpty = false {
//        didSet { changeButtonStateIfNeeded() }
//    }
//    var isCityNotEmpty = false {
//        didSet { changeButtonStateIfNeeded() }
//    }
//    var isPriceNotEmpty = false {
//        didSet { changeButtonStateIfNeeded() }
//    }
//    var isPhoneNotEmpty = false {
//        didSet { changeButtonStateIfNeeded() }
//    }
//
//
//    func changeButtonStateIfNeeded () {
//        if isTitleNotEmpty, isAuthorNotEmpty, isDescriptionNotEmpty, isCityNotEmpty, isPriceNotEmpty, isPhoneNotEmpty {
//            saveButton.isEnabled = true
//        } else {
//            saveButton.isEnabled = false
//        }
//    }
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let author = authorTextField.text, !author.isEmpty,
            let title = titleTextField.text, !title.isEmpty,
            let description = descriptionTextField.text, !description.isEmpty,
            let city = cityTextField.text, !city.isEmpty,
            let price = priceTextField.text, !price.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty
        else {
            saveButton.isEnabled = false
            return
        }
        saveButton.isEnabled = true
    }
}

extension NewBookViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.imageBookView.image = image
    }
}

extension UIImageView {
    func addText(_ text: String) {
        let lblText = UILabel(frame: self.bounds)
        lblText.text = text
        lblText.textAlignment = .center
        self.addSubview(lblText)
    }

    func removeAll() {
        for v in self.subviews { //удаляет все, если что-то другое добавили, проверять что v это UILabel
            v.removeFromSuperview()
        }
    }
}
