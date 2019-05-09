//
//  SettingsViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 6/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    let firebaseAuth = Auth.auth()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePictureUIImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        guard let user = firebaseAuth.currentUser else {return}
        guard let name = user.displayName else {return}
        guard let email = user.email else {return}

        nameLabel.text = name
        emailLabel.text = email

        profilePictureUIImageView.layer.borderColor = #colorLiteral(red: 0.7204067111, green: 0.7172593474, blue: 0.7385285497, alpha: 1)
        profilePictureUIImageView.layer.borderWidth = 5.0
        profilePictureUIImageView.layer.cornerRadius = profilePictureUIImageView.frame.size.width/2
        profilePictureUIImageView.layer.masksToBounds = false
        profilePictureUIImageView.clipsToBounds = true


    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {

        guard let user = firebaseAuth.currentUser else {return}
        guard let name = user.displayName else {return}
        let alert = UIAlertController(title: "Are you sure to logout \(name) ?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "YES", style: .default, handler: {Void in self.logout()})
        let cancelAction = UIAlertAction(title: "NO", style: .default, handler: {Void in})
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }

//    @IBAction func sendEmailTapped(_ sender: Any) {
//
//        guard let email = emailTextField.text else {return}
//
//        if(!(email.hasSuffix("@rmit.edu.au") || email.hasSuffix("@student.rmit.edu.au"))) {
//            let alert = UIAlertController(title: "This is not a RMIT Email", message: "", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
//            alert.addAction(okAction)
//            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
//
//        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
//
//            guard let error = error else {
//                let alert = UIAlertController(title: "Reset email was sent successfully!", message: "", preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in self.logout()})
//                alert.addAction(okAction)
//                self.present(alert, animated: true, completion: nil)
//
//                return
//            }
//            let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
//            alert.addAction(okAction)
//            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
//            self.present(alert, animated: true, completion: nil)
//
//        }
//    }

    private func logout() {

        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {

            let alert = UIAlertController(title: signOutError.localizedDescription, message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
            alert.addAction(okAction)
            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: nil)
        }
    }
}
