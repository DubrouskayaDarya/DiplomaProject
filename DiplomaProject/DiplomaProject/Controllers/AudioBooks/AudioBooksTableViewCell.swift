//
//  AudioBooksTableViewCell.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 27.04.22.
//

import UIKit
import Kingfisher

class AudioBooksTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with audioBook: ResultAudioBooks) {
        let url = URL(string: audioBook.artworkUrl100)
        
        iconView.kf.setImage(with: url)
        nameLabel?.text = audioBook.name
        authorLabel?.text = audioBook.artistName
    }
}
