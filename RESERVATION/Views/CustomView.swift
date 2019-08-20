//
//  File.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 19/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = HONEY_COLOR.cgColor
        backgroundColor = .darkGray
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -4, height: 4)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.65
    }
    
}
