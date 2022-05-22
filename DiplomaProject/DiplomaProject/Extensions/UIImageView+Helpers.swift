//
//  UIImageView+Helpers.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 22.05.22.
//

import UIKit

extension UIImageView {
    func addText(_ text: String) {
        let lblText = UILabel(frame: self.bounds)
        lblText.text = text
        lblText.textAlignment = .center
        self.addSubview(lblText)
    }

    func removeAll() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
