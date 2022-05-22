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
import Kingfisher
import PKHUD

class MyBookViewController: UIViewController {

    var user: User!
    var ref: DatabaseReference!
    var newBooks = [Book]()
    var imagePicker: ImagePicker!
    var book: Book!

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
        ref = Database.database().reference().child("users").child(user.uid).child("books")

        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        saveButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        authorTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        descriptionTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        cityTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        priceTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        let imageGestureRecognizer = UITapGestureRecognizer(target: nil, action: #selector(self.addImageTouchUpInside(_:)))
        imageBookView.addGestureRecognizer(imageGestureRecognizer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let _ = book else { return }
        setupUIWithData()
    }

    @IBAction @objc func addImageTouchUpInside(_ sender: UIButton) {
        imagePicker.present(from: sender)
    }

    @IBAction func saveBookTouchUpInside(_ sender: Any) {

        guard let image = imageBookView.image else {
            assertionFailure("Image was not selected")
            // показать собщение
            return
        }

        let keyValue = book == nil ? (ref.childByAutoId().key)! : (book?.ref?.key)! // убрать форс анврап

        HUD.show(.progress)
        uploadImage(image, for: keyValue) { [weak self] url in
            guard let self = self, let url = url else { return }
            let book = Book(title: self.titleTextField.text ?? "",
                userId: self.user.uid,
                author: self.authorTextField.text ?? "",
                description: self.descriptionTextField.text ?? "",
                city: self.cityTextField.text ?? "",
                price: self.priceTextField.text ?? "",
                phone: self.phoneTextField.text ?? "",
                imageUrl: url.absoluteString,
                ref: self.ref.child(keyValue))


            self.ref.child(keyValue).setValue(book.convertToDictionary())
            HUD.flash(.success, delay: 0.5)
        }
    }

    private func uploadImage(_ image: UIImage, for bookId: String, completionHandler: @escaping (URL?) -> Void) -> Void {
        let ref = Storage.storage().reference().child("images").child(bookId)
        guard let imageData = image.pngData() else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "images/png"

        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                assertionFailure("Can't upload image to firebase: \(String(describing: error))")
                completionHandler(nil)
                return
            }
            ref.downloadURL { url, error in
                guard let url = url else {
                    assertionFailure("Can't upload image to firebase: \(String(describing: error))")
                    completionHandler(nil)
                    return
                }
                completionHandler(url)
            }
        }
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        imageBookView.removeAll()
    }

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

    private func setupUIWithData() {
        titleTextField?.text = book.title
        authorTextField?.text = book.author
        descriptionTextField?.text = book.description
        cityTextField?.text = book.city
        priceTextField?.text = book.price
        phoneTextField?.text = book.phone
        let url = URL(string: book.imageUrl)
        imageBookView.kf.setImage(with: url)
        saveButton.isEnabled = true
    }
}

extension MyBookViewController: ImagePickerDelegate {
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
