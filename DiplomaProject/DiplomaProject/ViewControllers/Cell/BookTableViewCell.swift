//
//  BookTableViewCell.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 30.04.22.
//

import Firebase
import UIKit
import Kingfisher

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var imageBookView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with book: Book) {
        let url = URL(string: book.imageUrl)
        imageBookView.kf.setImage(with: url)
        titleLabel?.text = book.title
        authorLabel?.text = book.author
    }
}
