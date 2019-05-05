//
//  ContactsViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 4/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var existContacts = [Contact]()
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()

        JsonManager.getContacts() {contacts in
            DispatchQueue.main.async {
                if let contacts = contacts {
                    for existContact in contacts {
                        if existContact.deleted == false {
                            self.existContacts.append(existContact)
                        }
                    }
                    self.contactsTableView.reloadData()
                    self.clearLoading()
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existContacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! ContactsTableViewCell

        cell.nameLabel.text = existContacts[indexPath.row].name
        cell.phoneNumberLabel.text = existContacts[indexPath.row].phoneNo
        cell.emailLabel.text = existContacts[indexPath.row].emailID
        cell.departmentLabel.text = existContacts[indexPath.row].department.rawValue

        return cell
    }
    
    @IBAction func logoTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
