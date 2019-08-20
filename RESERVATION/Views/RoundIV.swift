//
//  RoundIV.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 19/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class RoundIV: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = frame.height / 2
        layer.borderColor = HONEY_COLOR.cgColor
        layer.borderWidth = 2
    }

}
