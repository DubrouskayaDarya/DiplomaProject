//
//  BooksTableViewCell.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 24.04.22.
//

import UIKit
import Kingfisher

class BooksTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with book: Result) {
        let url = URL(string: book.artworkUrl100)
        iconView.kf.setImage(with: url)
        nameLabel?.text = book.name
        authorLabel?.text = book.artistName
    }
}
