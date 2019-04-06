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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        guard let user = firebaseAuth.currentUser else {return}
        guard let name = user.displayName else {return}
        let alert = UIAlertController(title: "Are you sure to logout \(name) ?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in self.logout()})
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    private func logout() {
        let firebaseAuth = Auth.auth()
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
