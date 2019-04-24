//
//  NewsViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase
class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!

    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround() 
        let firebaseAuth = Auth.auth()
        guard let user = firebaseAuth.currentUser else {return}
        guard let name = user.displayName else {return}
        nameLabel.text = name
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        DispatchQueue.main.async {
            JsonManager.getFeeds() {feeds in
                if let feeds = feeds {
                    count = feeds.count
                }
            }
        }
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell

        JsonManager.getFeeds() {feeds in
            DispatchQueue.main.async {
                if let feeds = feeds {
                    cell.tittleLabel.text = feeds[indexPath.row].title
                    if let imageURL = feeds[indexPath.row].imageurl {

                        let url = URL(string: imageURL)
                        if let url = url {
                            let data = try? Data(contentsOf: url)
                            if let imageData = data {
                                cell.tittleUIImage.image = UIImage(data: imageData)
                            } else {
                                cell.tittleUIImage.image = UIImage.init(named: "rmit-building80")
                            }
                        } else {
                            cell.tittleUIImage.image = UIImage.init(named: "rmit-building80")
                        }
                    } else {
                        cell.tittleUIImage.image = UIImage.init(named: "rmit-building80")
                    }
                } else {
                    cell.tittleUIImage.image = UIImage.init(named: "rmit-building80")
                }
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }

}
