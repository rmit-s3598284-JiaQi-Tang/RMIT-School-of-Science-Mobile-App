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
    var subViewFrame: CGRect = CGRect(x:0 , y: 0, width: 0, height: 0)
    var subTitleLabelFrame: CGRect = CGRect(x:0 , y: 0, width: 0, height: 0)
    var subDateLabelFrame: CGRect = CGRect(x:0 , y: 0, width: 0, height: 0)
    var subTitleLabelFont: UIFont = UIFont(name: "Helvetica Neue", size: 20)!
    var subDateLabelFont: UIFont = UIFont(name: "Helvetica Neue", size: 15)!

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
        self.showLoading()

        generalButton.adjustsImageWhenDisabled = false
        researchButton.adjustsImageWhenDisabled = false
        learningButton.adjustsImageWhenDisabled = false

        JsonManager.getNewsFeeds(department: "GENERAL") {feeds in
            DispatchQueue.main.async {

                self.subViewFrame = self.subView.frame
                self.subTitleLabelFrame = self.subTitleLabel.frame
                self.subDateLabelFrame = self.subDateLabel.frame
                self.subTitleLabelFont = self.subTitleLabel.font
                self.subDateLabelFont = self.subDateLabel.font

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
                        for index in 0..<self.existFeeds.count {
                            self.newestFeeds.append(self.existFeeds[index])
                        }
                    }
                }
                self.newsTableView.reloadData()
                self.updateScrollView()
                self.scrollView.delegate = self

                self.clearLoading()
            }
            
        }
        
        generalButton.backgroundColor = UIColor.darkGray
        generalButton.isEnabled = false
        researchButton.backgroundColor = UIColor.black
        researchButton.isEnabled = true
        learningButton.backgroundColor = UIColor.black
        learningButton.isEnabled = true

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existFeeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell

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

        performSegue(withIdentifier: "showNewsContentSegue", sender: nil)
    }

    //scroll view method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

    @IBAction func generalButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        newestFeeds.removeAll()
        self.showLoading()
        JsonManager.getNewsFeeds(department: "GENERAL") {feeds in
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
                        for index in 0..<self.existFeeds.count {
                            self.newestFeeds.append(self.existFeeds[index])
                        }
                    }
                }
                self.newsTableView.reloadData()
                self.updateScrollView()
                self.clearLoading()
            }
        }
        generalButton.backgroundColor = UIColor.darkGray
        generalButton.isEnabled = false
        researchButton.backgroundColor = UIColor.black
        researchButton.isEnabled = true
        learningButton.backgroundColor = UIColor.black
        learningButton.isEnabled = true
    }

    @IBAction func researchButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        newestFeeds.removeAll()
        self.showLoading()
        JsonManager.getNewsFeeds(department: "RESEARCH") {feeds in
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
                        for index in 0..<self.existFeeds.count {
                            self.newestFeeds.append(self.existFeeds[index])
                        }
                    }
                }
                self.newsTableView.reloadData()
                self.updateScrollView()
                self.clearLoading()
            }
        }
        generalButton.backgroundColor = UIColor.black
        generalButton.isEnabled = true
        researchButton.backgroundColor = UIColor.darkGray
        researchButton.isEnabled = false
        learningButton.backgroundColor = UIColor.black
        learningButton.isEnabled = true
    }

    @IBAction func learningButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        newestFeeds.removeAll()
        self.showLoading()
        JsonManager.getNewsFeeds(department: "Learning") {feeds in
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
                        for index in 0..<self.existFeeds.count {
                            self.newestFeeds.append(self.existFeeds[index])
                        }
                    }
                }
                self.newsTableView.reloadData()
                self.updateScrollView()
                self.clearLoading()
            }
        }
        generalButton.backgroundColor = UIColor.black
        generalButton.isEnabled = true
        researchButton.backgroundColor = UIColor.black
        researchButton.isEnabled = true
        learningButton.backgroundColor = UIColor.darkGray
        learningButton.isEnabled = false
    }

    private func updateScrollView() {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        self.pageControl.numberOfPages = self.newestFeeds.count
        for index in 0..<self.newestFeeds.count {
            var frame = CGRect(x:0 , y: 0, width: 0, height: 0)
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            let view = UIView(frame: frame)
            let imageView = UIImageView(frame: subViewFrame)
            let tittleLabel = UILabel(frame: subTitleLabelFrame)
            let dateLabel = UILabel(frame: subDateLabelFrame)

            tittleLabel.font = subTitleLabelFont
            tittleLabel.textColor = .white
            tittleLabel.numberOfLines = 3
            tittleLabel.textAlignment = .center

            dateLabel.font = subDateLabelFont
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
        self.scrollView.contentSize = CGSize(width: (self.scrollView.frame.size.width * CGFloat(self.newestFeeds.count)), height: self.scrollView.frame.size.height)
    }
}



