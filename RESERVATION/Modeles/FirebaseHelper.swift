//
//  FirebaseHelper.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 22/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class FirebaseHelper {
    
    var result: ((_ bool: Bool?, _ erreur: Error?) -> Void)?
    var userValues: [String: String] = [:]
    
    //Vérifier si utilisateur est connecté
    func connecte() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    //Authentification
    
    func signIn(_ mail: String, _ password: String, result: ((_ bool: Bool?, _ erreur: Error?) -> Void)?) {
        self.result = result
        Auth.auth().signIn(withEmail: mail, password: password, completion: completion)
    }
    
    func create(_ mail: String, _ password: String, _ username: String, result: ((_ bool: Bool?, _ erreur: Error?) -> Void)?) {
        self.result = result
        self.userValues = ["username": username]
        Auth.auth().createUser(withEmail: mail, password: password, completion: completion)
    }
    
    func completion(_ result: AuthDataResult?, _ error: Error?) {
        if let erreur = error {
            print(erreur.localizedDescription)
            // Notifie une erreur
            self.result?(false, erreur)
        }
        if let id = result?.user.uid {
            // Mettre à jour ma base de données
            updateUser(id, dict: self.userValues)
            // Notifie une completion OK
            self.result?(true, nil)
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Acces base de Données
    
    
    private var _database = Database.database().reference()
    
    private var _databaseUser: DatabaseReference {
        return _database.child("users")
    }
    
    private var _databaseQuestion: DatabaseReference {
        return _database.child("Questions")
    }
    
    func updateUser(_ id: String, dict: [String: String]) {
        _databaseUser.child(id).updateChildValues(dict)
        userValues = [:]
    }
    
    func getUser(_ id: String, completion: ((BeeUser?) -> Void)?) {
        _databaseUser.child(id).observe(.value) { (data) in
            completion?(BeeUser(data: data))
        }
    }
    
    func usernameExists(_ username: String?, completion: ((Bool, String) -> Void)?) {
        if let string = username {
            if string.count > 6 {
                _databaseUser.queryOrdered(byChild: "username").queryEqual(toValue: string).observeSingleEvent(of: .value) { (data) in
                    if data.exists() {
                        completion?(false, "Username déjà pris")
                    } else {
                        completion?(true, "")
                    }
                }
            } else {
                completion?(false, "Username trop court")
            }
        } else {
            completion?(false, "Username vide")
        }
    }
    
    func saveQuestion(_ string: String) {
        guard let id = connecte() else { return }
        let dict: [String: String] = [
            "userId": id,
            "questionString": string,
            "date": Date().toString(),
        ]
        _databaseQuestion.childByAutoId().updateChildValues(dict)
    }
    
    /*func getQuestion(completion: ((Question)-> Void)?) {
        _databaseQuestion.observe(.childAdded) { (data) in
            if let dict = data.value as? [String: Any] {
                if let date = dict["date"] as? String {
                    if let userId = dict["userId"] as? String {
                        if let str = dict["questionString"] as? String {
                            let new = Question(ref: data.ref, id: data.key, date: date, userId: userId, questionString: str)
                            completion?(new)
                        }
                    }
                }
            }
        }
    }*/
    
    func saveAnswer(ref: DatabaseReference, texte: String?, image: String?, height: CGFloat?) {
        guard let id = connecte() else { return }
        var dict: [String: Any] = [
            "userId": id,
            "date": Date().toString()
        ]
        if texte != nil {
            dict["texte"] = texte!
        }
        if image != nil {
            dict["imageUrl"] = image!
        }
        if height != nil {
            dict["height"] = height!
        }
        ref.child("answers").childByAutoId().updateChildValues(dict)
        
    }
    
   /*func getAnswer(ref: DatabaseReference, completion: ((Answer) -> Void)?) {
        ref.child("answers").observe(.childAdded) { (data) in
            if let dict = data.value as? [String: Any] {
                if let userId = dict["userId"] as? String {
                    let answer = getAnswer(userId: userId, data: data)
                    completion?(answer)
                }
            }
        }
    }
    */
    
    /// Storage
    private let _storage = Storage.storage().reference()
    private var _storageUser: StorageReference {
        return _storage.child("users")
    }
    private var _storageAnswers: StorageReference {
        return _storage.child("answers")
    }
    
    func addProfilePicture(_ data: Data) {
        guard let id = connecte() else { return }
        let reference = _storageUser.child(id)
        reference.putData(data, metadata: nil) { (meta, error) in
            if error == nil {
                reference.downloadURL(completion: { (url, error) in
                    if let urlString = url?.absoluteString {
                        self.updateUser(id, dict: ["imageUrl": urlString])
                    }
                })
            }
        }
    }
    
    func addImageAnswer(_ data: Data, completion: ((String?) -> Void)?) {
        let uniqueId = UUID().uuidString
        let ref = _storageAnswers.child(uniqueId)
        ref.putData(data, metadata: nil) { (meta, error) in
            if error != nil {
                completion?(nil)
            } else {
                ref.downloadURL(completion: { (url, error) in
                    if error == nil, let urlString = url?.absoluteString {
                        completion?(urlString)
                    } else {
                        completion?(nil)
                    }
                })
            }
        }
    }
    
    
}
