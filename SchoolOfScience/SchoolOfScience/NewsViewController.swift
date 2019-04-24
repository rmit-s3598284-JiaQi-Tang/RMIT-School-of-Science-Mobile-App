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

    var existFeeds = [Feed]()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!

    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround() 
        let firebaseAuth = Auth.auth()
        guard let user = firebaseAuth.currentUser else {return}
        guard let name = user.displayName else {return}
        nameLabel.text = name


        JsonManager.getFeeds() {feeds in
            DispatchQueue.main.async {
                if let feeds = feeds {
                    for existFeed in feeds {
                        if existFeed.deleted == false {
                            self.existFeeds.append(existFeed)
                        }
                    }
                }
                self.newsTableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existFeeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell

        cell.tittleLabel.text = self.existFeeds[indexPath.row].title
        if let imageURL = self.existFeeds[indexPath.row].imageurl {

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
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }

}
