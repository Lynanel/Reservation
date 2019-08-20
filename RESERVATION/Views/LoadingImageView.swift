//
//  LoadingImageView.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 20/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView {
    
    var timer = Timer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        image = UIImage(named: "darkBee")
        contentMode = .scaleAspectFit
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (t) in
            UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        })
    }
    
    func stop() {
        timer.invalidate()
    }
    

}
