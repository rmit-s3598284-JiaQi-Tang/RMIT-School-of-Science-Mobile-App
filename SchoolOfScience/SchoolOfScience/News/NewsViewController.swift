//
//  NewsViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase
class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var existFeeds = [Feed]()
    var newestFeeds = [Feed]()
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var researchButton: UIButton!
    @IBOutlet weak var learningButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subDateLabel: UILabel!



    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround() 
//        let firebaseAuth = Auth.auth()
//        guard let user = firebaseAuth.currentUser else {return}
//        guard let name = user.displayName else {return}
//        nameLabel.text = name
        self.showBeingLogin()
        JsonManager.getFeeds(department: "GENERAL") {feeds in
            DispatchQueue.main.async {

                if let feeds = feeds {
                    for existFeed in feeds {
                        if existFeed.deleted == false {
                            self.existFeeds.append(existFeed)
                        }
                    }
                    if(self.existFeeds.count >= 3) {
                        self.newestFeeds.append(self.existFeeds[0])
                        self.newestFeeds.append(self.existFeeds[1])
                        self.newestFeeds.append(self.existFeeds[2])
                    } else {
                        for index in 1...self.existFeeds.count {
                            self.newestFeeds.append(self.existFeeds[index-1])
                        }
                    }
                }
                self.newsTableView.reloadData()
                self.pageControl.numberOfPages = self.newestFeeds.count
                for index in 0..<self.newestFeeds.count {
                    print(index)
                    var frame = CGRect(x:0 , y: 0, width: 0, height: 0)
                    frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                    frame.size = self.scrollView.frame.size
                    let view = UIView(frame: frame)
                    let imageView = UIImageView(frame: self.subView.frame)
                    let tittleLabel = UILabel(frame: self.subTitleLabel.frame)
                    let dateLabel = UILabel(frame: self.subDateLabel.frame)

                    tittleLabel.font = self.subTitleLabel.font
                    tittleLabel.textColor = .white
                    tittleLabel.numberOfLines = 3
                    tittleLabel.textAlignment = .center

                    dateLabel.font = self.subDateLabel.font
                    dateLabel.textColor = .white
                    dateLabel.numberOfLines = 3
                    dateLabel.textAlignment = .center

                    imageView.alpha = 0.6
                    imageView.image = self.getPictureFromURL(url: self.newestFeeds[index].imageurl)

                    //blur the background picture
                    let regularBlur = UIBlurEffect(style: .regular)
                    let blurView = UIVisualEffectView(effect: regularBlur)
                    blurView.frame = imageView.bounds
                    blurView.alpha = 0.6
                    imageView.addSubview(blurView)

                    tittleLabel.text = self.newestFeeds[index].title
                    dateLabel.text = self.getDateFromSeconds(seconds: self.newestFeeds[index].createdDate)

                    view.addSubview(imageView)
                    view.addSubview(tittleLabel)
                    view.addSubview(dateLabel)

                    self.scrollView.addSubview(view)
                }
                self.subTitleLabel.text = ""
                self.subDateLabel.text = ""
                self.scrollView.contentSize = CGSize(width: (self.scrollView.frame.size.width * CGFloat(self.newestFeeds.count)), height: self.scrollView.frame.size.height)
                self.scrollView.delegate = self

                self.clearBeingLogin()
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

        let stringDate = self.getDateFromSeconds(seconds: self.existFeeds[indexPath.row].createdDate)
        cell.dateLabel.text = stringDate
        cell.tittleUIImage.image = getPictureFromURL(url: existFeeds[indexPath.row].imageurl)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(125)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //convert date
        let stringDate = self.getDateFromSeconds(seconds: self.existFeeds[indexPath.row].createdDate)

        //convert imageURL
        let image = self.getPictureFromURL(url: self.existFeeds[indexPath.row].imageurl)

        NewsModel.upDateDisplayingNews(title: existFeeds[indexPath.row].title!, content: existFeeds[indexPath.row].news!, date: stringDate, image: image!)

        performSegue(withIdentifier: "showContentSegue", sender: nil)
    }

    //scroll view method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
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

    private func getPictureFromURL(url: String?) -> UIImage? {
        if let imageURL = url {
            let url = URL(string: imageURL)
            if let url = url {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    return UIImage(data: imageData)
                } else {
                    return UIImage.init(named: "rmit-building80")
                }
            } else {
                return UIImage.init(named: "rmit-building80")
            }
        } else {
            return UIImage.init(named: "rmit-building80")
        }
    }

    private func getDateFromSeconds(seconds: Double) -> String {
        let timeInterval = seconds/1000
        let myDate = Date(timeIntervalSince1970: Double(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.string(from: myDate as Date)
    }

    private func showBeingLogin(){
            self.view.makeToastActivityWithMessage(message: "Loading…")
            self.view.isUserInteractionEnabled = false
    }

    private func clearBeingLogin(){
            self.view.hideToastActivity()
            self.view.isUserInteractionEnabled = true
    }
}


