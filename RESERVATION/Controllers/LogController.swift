//
//  LogController.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 22/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class LogController: MoveableController {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passworddTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var usernameErrorLbl: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var logView: CustomView!
    @IBOutlet weak var centerViewConstraint: NSLayoutConstraint!
    
    var canAdd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addTap()
    }
    
    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        checkHeight(logView, constraint: centerViewConstraint)
    }
    
    override func hideKey(notification: Notification) {
        super.hideKey(notification:  notification)
        animation(0, centerViewConstraint)
    }
    
    
    func setup() {
        switch segmented.selectedSegmentIndex {
        case 0:
            usernameTF.isHidden = true
            connectButton.setTitle("Se Connecter", for: .normal)
        default:
            usernameTF.isHidden = false
            connectButton.setTitle("Créer un compte", for: .normal)
        }
    }
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        setup()
    }
    
    
    @IBAction func usernameChanged(_ sender: UITextField) {
        // Vérifier dans la base de données si Username existe
        FirebaseHelper().usernameExists(sender.text) { (bool, string) in
            DispatchQueue.main.async {
                self.canAdd = bool
                self.usernameErrorLbl.text = string
            }
        }
    }
    
    @IBAction func connectPressed(_ sender: Any) {
        // Vérifier si mail et mot de passe
        if let mail = emailTF.text, mail != "" {
            if let mdp = passworddTF.text, mdp != "" {
                if segmented.selectedSegmentIndex == 0 {
                    FirebaseHelper().signIn(mail, mdp, result: logCompletion)
                } else {
                    // Verifie si Username Exists
                    if canAdd, let username = usernameTF.text {
                        FirebaseHelper().create(mail, mdp, username, result: logCompletion)
                    }
                }
            } else {
                AlertHelper().erreurSimple(self, message: "Mot de passe vide")
            }
        } else {
            AlertHelper().erreurSimple(self, message: "Adresse mail vide")
        }
        
    }
    
    func logCompletion(_ bool: Bool?, _ error: Error?) {
        if error != nil {
            AlertHelper().erreurSimple(self, message: error!.localizedDescription)
        }
        if bool != nil, bool! == true {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
