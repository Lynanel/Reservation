//
//  MoveableController.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 22/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

// Déplacer vue et observer le clavier et ajouter tapGesture

class MoveableController: UIViewController {

    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Envoie une notification pour afficher le clavier
        NotificationCenter.default.addObserver(self, selector: #selector(showKey), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        //Envoie une notification pour cacher le clavier
        NotificationCenter.default.addObserver(self, selector: #selector(hideKey), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKey(notification: Notification) {
        if let keyHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            height = keyHeight
        }
    }
    
    @objc func hideKey(notification: Notification) {
        // Rien pour l'instant
    }
    
    func addTap() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap() {
        view.endEditing(true)
    }
    
    func animation(_ constante: CGFloat, _ constraint: NSLayoutConstraint) {
        UIView.animate(withDuration: 0.3) {
            constraint.constant = constante
        }
    }
    
    func checkHeight(_ view: UIView, constraint: NSLayoutConstraint) {
        let bottom = view.frame.maxY
        let screenHeight = UIScreen.main.bounds.height
        let remain = screenHeight - bottom
        //Vérifie si la hauteur sortie de notre clavier (height) est supérieure à l'espace (remain +20) qui reste de votre vue et le bas de notre écran, alors j'ajoute une constante
        if height > remain {
            let constant = remain - height
            animation(constant, constraint)
        }
    }

}
