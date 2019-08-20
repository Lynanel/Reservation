//
//  ViewController.swift
//  RESERVATION
//
//  Created by TRAORE Lionel on 8/19/19.
//  Copyright © 2019 TRAORE Lionel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileIV: RoundIV!
    
    var beeUser: BeeUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logButtonPressed(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id = FirebaseHelper().connecte() {
            // L'utilisateur est connecté récupérer beeUser
            FirebaseHelper().getUser(id) { (bee) in
                DispatchQueue.main.async {
                    self.beeUser = bee
                    if self.beeUser != nil {
                        self.profileIV.download(string: self.beeUser!.imageUrl)
                        self.usernameLabel.text = self.beeUser!.username
                        self.logButton.setTitle("Profil", for: .normal)
                    }
                }
            }
        } else {
            //Pas d'utilisateur
            self.beeUser = nil
            logButton.setTitle("Se connecter", for: .normal)
            usernameLabel.text = ""
        }
    }
    
    @IBAction func logButtonPressed(_ sender: Any) {
        if beeUser != nil {
            //Va vers profile
            performSegue(withIdentifier: "Profile", sender: beeUser!)
        } else {
            //Va vers Connection
            performSegue(withIdentifier: "Log", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profile" {
            if let nav = segue.destination as? Nav {
                if let first = nav.topViewController as? ProfileController {
                    first.beeUser = sender as? BeeUser
                }
            }
        }
    }
}

