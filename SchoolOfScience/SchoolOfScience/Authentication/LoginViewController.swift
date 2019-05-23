//
//  ViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 3/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        loginButton.layer.cornerRadius = 10.0
        signupButton.layer.cornerRadius = 10.0
    }
    override func viewDidAppear(_ animated: Bool) {
        if(Auth.auth().currentUser != nil) {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}

        if(!(email.hasSuffix("@rmit.edu.au") || email.hasSuffix("@student.rmit.edu.au"))) {
            let alert = UIAlertController(title: "This is not a RMIT Email", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
            alert.addAction(okAction)
            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in

            if let error = error {
                let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
                alert.addAction(okAction)
                alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                self.present(alert, animated: true, completion: nil)

            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }

        //new try
//        APIManager.login(username: email, password: password)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

