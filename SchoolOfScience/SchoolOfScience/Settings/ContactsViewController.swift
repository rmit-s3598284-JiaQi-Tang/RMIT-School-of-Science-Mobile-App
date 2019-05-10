//
//  ContactsViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 4/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var existContacts = [Contact]()
    var filteredContacts = [Contact]()

    var isSearching = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.showLoading()

        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

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
        return 160
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredContacts.count
        }
        return existContacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! ContactsTableViewCell

        if isSearching {
            cell.nameLabel.text = filteredContacts[indexPath.row].name
            cell.phoneNumberLabel.text = filteredContacts[indexPath.row].phoneNo
            cell.emailLabel.text = filteredContacts[indexPath.row].emailID
            cell.departmentLabel.text = filteredContacts[indexPath.row].department.rawValue
        } else {
            cell.nameLabel.text = existContacts[indexPath.row].name
            cell.phoneNumberLabel.text = existContacts[indexPath.row].phoneNo
            cell.emailLabel.text = existContacts[indexPath.row].emailID
            cell.departmentLabel.text = existContacts[indexPath.row].department.rawValue
        }

        return cell
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
//            view.endEditing(true)
            contactsTableView.reloadData()
        } else {
            isSearching = true
            filteredContacts.removeAll()
            for contacts in existContacts {
                if(contacts.name.lowercased().contains(searchBar.text!.lowercased())) {
                    filteredContacts.append(contacts)
                }
                if(contacts.department.rawValue.lowercased().contains(searchBar.text!.lowercased())) {
                    filteredContacts.append(contacts)
                }
                if let email = contacts.emailID {
                    if(email.lowercased().contains(searchBar.text!.lowercased())) {
                        filteredContacts.append(contacts)
                    }
                }
                if let phoneNo = contacts.phoneNo {
                    if(phoneNo.lowercased().contains(searchBar.text!.lowercased())) {
                        filteredContacts.append(contacts)
                    }
                }
            }
            contactsTableView.reloadData()
        }
    }

    
    @IBAction func logoTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
