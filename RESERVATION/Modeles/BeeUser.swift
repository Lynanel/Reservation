//
//  BeeUser.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 22/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import Foundation
import FirebaseDatabase

class BeeUser {
    
    private var _ref: DatabaseReference
    private var _id: String
    private var _username: String?
    private var _imageUrl: String?
    
    var id: String {
        return _id
    }
    
    var username: String {
        return _username ?? "Anonyme"
    }
    
    var imageUrl: String {
        return _imageUrl ?? ""
    }
    
    init(data: DataSnapshot) {
        self._ref = data.ref
        self._id = data.key
        if let dict = data.value as? [String: String] {
            self._username = dict["username"]
            self._imageUrl = dict["imageUrl"]
        }
    }
    
}
