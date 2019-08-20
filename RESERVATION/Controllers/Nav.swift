//
//  Nav.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 19/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class Nav: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = .darkGray
        navigationBar.tintColor = HONEY_COLOR
        navigationBar.titleTextAttributes = [
            .foregroundColor: HONEY_COLOR,
            .font: UIFont.italicSystemFont(ofSize: 20)
        ]

    }
}
