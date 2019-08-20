//
//  Extension UI.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 19/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit
import SDWebImage

extension UITableView {
    
    func setup(color: UIColor) {
        backgroundColor = color
        separatorStyle = .none
        tableFooterView = UIView()
    }
    
}

extension UITableViewCell {
    
    func setup() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }
    
}

extension UIImageView {
    
    func download(string: String) {
        sd_setImage(with: URL(string: string), placeholderImage: BUMBLE_IMAGE, options: SDWebImageOptions.highPriority, completed: nil)
    }
}
