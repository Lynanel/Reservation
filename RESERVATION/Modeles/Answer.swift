//
//  Answer.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 23/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Answer {
    
    private var _ref: DatabaseReference
    private var _id: String
    private var _userId: String
    private var _date: String?
    private var _texte: String?
    private var _imageUrl: String?
    private var _imageHeight: CGFloat?
    
    var ref: DatabaseReference {
        return _ref
    }
    
    var id: String {
        return _id
    }
    
    var userId: String {
        return _userId
    }
    
    var date: String {
        return _date ?? Date().toString()
    }
    
    var texte: String? {
        return _texte
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var imageHeight: CGFloat? {
        return _imageHeight
    }
    
    init(userId: String, data: DataSnapshot) {
        self._ref = data.ref
        self._id = data.key
        self._userId = userId
        if let dict = data.value as? [String: Any] {
            self._texte = dict["texte"] as? String
            self._imageUrl = dict["imageUrl"] as? String
            self._imageHeight = dict["height"] as? CGFloat
            self._date = dict["date"] as? String
        }
    }
}
