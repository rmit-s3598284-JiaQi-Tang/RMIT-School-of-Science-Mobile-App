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
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var researchButton: UIButton!
    @IBOutlet weak var learningButton: UIButton!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround() 
//        let firebaseAuth = Auth.auth()
//        guard let user = firebaseAuth.currentUser else {return}
//        guard let name = user.displayName else {return}
//        nameLabel.text = name


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
        generalButton.backgroundColor = UIColor.darkGray
        researchButton.backgroundColor = UIColor.black
        learningButton.backgroundColor = UIColor.black
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(existFeeds.count)
        return existFeeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell

        cell.tittleLabel.text = self.existFeeds[indexPath.row].title


        let timeInterval = self.existFeeds[indexPath.row].createdDate/1000
        let myDate = Date(timeIntervalSince1970: Double(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"

        let stringDate = formatter.string(from: myDate as Date)
        cell.dateLabel.text = stringDate
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
        return CGFloat(125)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //convert date
        let timeInterval = self.existFeeds[indexPath.row].createdDate/1000
        let myDate = Date(timeIntervalSince1970: Double(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let stringDate = formatter.string(from: myDate as Date)

        //convert imageURL
        var image = UIImage.init(named: "rmit-building80")
        if let imageURL = self.existFeeds[indexPath.row].imageurl {

            let url = URL(string: imageURL)
            if let url = url {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    image = UIImage(data: imageData)
                }
            }
        }
        NewsModel.upDateDisplayingNews(title: existFeeds[indexPath.row].title!, content: existFeeds[indexPath.row].news!, date: stringDate, image: image!)

        performSegue(withIdentifier: "showContentSegue", sender: nil)
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
        generalButton.backgroundColor = UIColor.black
        researchButton.backgroundColor = UIColor.black
        learningButton.backgroundColor = UIColor.darkGray
    }
}


