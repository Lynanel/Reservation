//
//  Question.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 23/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Question {
    
    private var _ref: DatabaseReference
    private var _id: String
    private var _date: String
    private var _userId: String
    private var _questionString: String
    
    var ref: DatabaseReference {
        return _ref
    }
    
    var id: String {
        return _id
    }
    
    var date: String {
        return _date
    }
    
    var userId: String {
        return _userId
    }
    var questionString: String {
        return _questionString
    }
    
    init(ref: DatabaseReference, id: String, date: String, userId: String, questionString: String) {
        self._ref = ref
        self._id = id
        self._date = date
        self._userId = userId
        self._questionString = questionString
    }
    
}
