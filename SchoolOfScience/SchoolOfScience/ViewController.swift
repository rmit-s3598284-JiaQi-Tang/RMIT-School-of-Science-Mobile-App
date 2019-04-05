//
//  ViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 3/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
class ViewController: UIViewController {


    @IBAction func loginTapped(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()

        guard authUI != nil else {
            return
        }

        authUI?.delegate = self
        let authViewCountroller = authUI!.authViewController()

        present(authViewCountroller, animated: true, completion: nil)
    }

}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {

        if error != nil {
            return
        }

        performSegue(withIdentifier: "loginSegue", sender: self)
    }
}

