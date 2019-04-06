//
//  SignUpViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 6/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let name = nameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let confirmPassword = confirmPasswordTextField.text else {return}

        if (password != confirmPassword) {

            let alert = UIAlertController(title: "Password does not match !", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
            alert.addAction(okAction)
            alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
            self.present(alert, animated: true, completion: nil)
            return

        } else {

            Auth.auth().createUser(withEmail: email, password: password, completion: {(resulet, error) in

                if let error = error {
                    let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
                    alert.addAction(okAction)
                    alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                    self.present(alert, animated: true, completion: nil)

                } else {

                    if let user = resulet?.user {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = name
                        changeRequest.commitChanges(completion: { error in
                            if let error = error {
                                let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
                                alert.addAction(okAction)
                                alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                        })
                    }
                    let alert = UIAlertController(title: "User created successfully !", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in self.dismiss(animated: true, completion: nil)})
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            })

        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
