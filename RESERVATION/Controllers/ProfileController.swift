//
//  ProfileController.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 22/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class ProfileController: MoveableController {
    
    @IBOutlet weak var profileIV: RoundIV!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var valideButton: UIButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!

    var beeUser: BeeUser?
    var canAdd = false
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
        if let user = beeUser {
            profileIV.download(string: user.imageUrl)
            usernameTF.placeholder = user.username
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, centerConstraint)
    }
    
    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(valideButton, constraint: centerConstraint)
    }
   
    @IBAction func cameraAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func libraryAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func logAction(_ sender: Any) {
        // Se déconnecter et dismiss
        FirebaseHelper().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func validateAction(_ sender: Any) {
        view.endEditing(true)
        if canAdd, usernameTF.text != nil {
            if let user = beeUser {
                FirebaseHelper().updateUser(user.id, dict: ["username": self.usernameTF.text!])
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func usernameEnter(_ sender: UITextField) {
        FirebaseHelper().usernameExists(sender.text) { (bool, string) in
            DispatchQueue.main.async {
                self.errorLbl.text = string
                self.canAdd = bool
            }
        }
    }
}


extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originale = info[.originalImage] as? UIImage {
            self.profileIV.image = originale
            
            // Formatte image pour database
            if let data = originale.jpegData(compressionQuality: 0.2) {
                FirebaseHelper().addProfilePicture(data)
            }
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
