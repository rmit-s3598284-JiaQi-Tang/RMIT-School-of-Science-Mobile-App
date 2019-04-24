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
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var researchButton: UIButton!
    @IBOutlet weak var learningButton: UIButton!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround() 
        let firebaseAuth = Auth.auth()
        guard let user = firebaseAuth.currentUser else {return}
        guard let name = user.displayName else {return}
        nameLabel.text = name


        JsonManager.getFeeds(department: "RESEARCH") {feeds in
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
        print(existFeeds.count)
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

    @IBAction func allButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        JsonManager.getFeeds(department: "ALL") {feeds in
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
        allButton.backgroundColor = UIColor.darkGray
        generalButton.backgroundColor = UIColor.black
        researchButton.backgroundColor = UIColor.black
        learningButton.backgroundColor = UIColor.black
    }

    @IBAction func generalButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        JsonManager.getFeeds(department: "GENERAL") {feeds in
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
        allButton.backgroundColor = UIColor.black
        generalButton.backgroundColor = UIColor.darkGray
        researchButton.backgroundColor = UIColor.black
        learningButton.backgroundColor = UIColor.black
    }

    @IBAction func researchButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        JsonManager.getFeeds(department: "RESEARCH") {feeds in
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
        allButton.backgroundColor = UIColor.black
        generalButton.backgroundColor = UIColor.black
        researchButton.backgroundColor = UIColor.darkGray
        learningButton.backgroundColor = UIColor.black
    }

    @IBAction func learningButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        JsonManager.getFeeds(department: "Learning") {feeds in
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
        allButton.backgroundColor = UIColor.black
        generalButton.backgroundColor = UIColor.black
        researchButton.backgroundColor = UIColor.black
        learningButton.backgroundColor = UIColor.darkGray
    }
}
