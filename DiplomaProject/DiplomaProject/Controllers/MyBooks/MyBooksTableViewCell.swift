//
//  MyBooksTableViewCell.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 30.04.22.
//

import UIKit

class MyBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var myBookImageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure() {
//        let url = URL(string: book.artworkUrl100)
//        iconView.kf.setImage(with: url)
//        titleLabel?.text = "book.name"
//        authorLabel?.text = "book.artistName"
    }
}
