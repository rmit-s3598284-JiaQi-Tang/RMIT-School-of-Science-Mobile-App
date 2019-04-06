//
//  ForgetPassowrdViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 6/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase
class ForgetPassowrdViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendEmailButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else {return}

        Auth.auth().sendPasswordReset(withEmail: email) { (error) in

            guard let error = error else {
                let alert = UIAlertController(title: "Reset email was sent successfully!", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in self.dismiss(animated: true, completion: nil)})
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
                let alert = UIAlertController(title: error.localizedDescription, message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {Void in})
                alert.addAction(okAction)
                alert.setValue(NSAttributedString(string: alert.title!, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor : UIColor.red]), forKey: "attributedTitle")
                self.present(alert, animated: true, completion: nil)

        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
