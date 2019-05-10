//
//  CalendarViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 6/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit
import Firebase

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var existFeeds = [Feed]()
    var newestFeeds = [EventsViewModel]()
    var existEvents = [EventsViewModel]()
    
    var subViewFrame: CGRect = CGRect(x:0 , y: 0, width: 0, height: 0)
    var subTitleLabelFrame: CGRect = CGRect(x:0 , y: 0, width: 0, height: 0)
    var subDateLabelFrame: CGRect = CGRect(x:0 , y: 0, width: 0, height: 0)
    var subTitleLabelFont: UIFont = UIFont(name: "Helvetica Neue", size: 20)!
    var subDateLabelFont: UIFont = UIFont(name: "Helvetica Neue", size: 15)!

    @IBOutlet weak var EventsTableView: UITableView!
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var researchButton: UIButton!
    @IBOutlet weak var learningButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var subDateLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    


    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        self.showLoading()

        generalButton.adjustsImageWhenDisabled = false
        researchButton.adjustsImageWhenDisabled = false
        learningButton.adjustsImageWhenDisabled = false

        generalButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0).isActive=true
        researchButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 32 )/3).isActive = true
        researchButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 0).isActive = true
        learningButton.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0).isActive=true
        
        JsonManager.getEventsFeeds(department: "GENERAL") {feeds in
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
                    self.updateModelView()
                    self.updateNewestFeeds()
                }
                self.EventsTableView.reloadData()
                self.updateScrollView()
                self.scrollView.delegate = self

                self.clearLoading()
            }

        }

        generalButton.backgroundColor = #colorLiteral(red: 0.7848398089, green: 0.1659219265, blue: 0.1861632168, alpha: 1)
        generalButton.setTitleColor(.white, for: .normal)
        generalButton.isEnabled = false
        researchButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        researchButton.backgroundColor = UIColor.black
        researchButton.isEnabled = true
        learningButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        learningButton.backgroundColor = UIColor.black
        learningButton.isEnabled = true

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return existEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventsTableViewCell

        cell.tittleLabel.text = self.existEvents[indexPath.row].title
        cell.dateLabel.text = self.existEvents[indexPath.row].date
        cell.tittleUIImage.image = self.existEvents[indexPath.row].image

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(125)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        EventsModel.upDateDisplayingEvents(title: existEvents[indexPath.row].title!, content: existEvents[indexPath.row].content!, date: existEvents[indexPath.row].date, image: existEvents[indexPath.row].image)
        
        performSegue(withIdentifier: "showEventContentSegue", sender: nil)
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
        JsonManager.getEventsFeeds(department: "GENERAL") {feeds in
            DispatchQueue.main.async {
                if let feeds = feeds {
                    for existFeed in feeds {
                        if existFeed.deleted == false {
                            self.existFeeds.append(existFeed)
                        }
                    }
                    self.updateModelView()
                    self.updateNewestFeeds()
                }
                self.EventsTableView.reloadData()
                self.updateScrollView()
                self.clearLoading()
            }
        }
        generalButton.backgroundColor = #colorLiteral(red: 0.7848398089, green: 0.1659219265, blue: 0.1861632168, alpha: 1)
        generalButton.setTitleColor(.white, for: .normal)
        generalButton.isEnabled = false
        researchButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        researchButton.backgroundColor = UIColor.black
        researchButton.isEnabled = true
        learningButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        learningButton.backgroundColor = UIColor.black
        learningButton.isEnabled = true
    }

    @IBAction func researchButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        newestFeeds.removeAll()
        self.showLoading()
        JsonManager.getEventsFeeds(department: "RESEARCH") {feeds in
            DispatchQueue.main.async {
                if let feeds = feeds {
                    for existFeed in feeds {
                        if existFeed.deleted == false {
                            self.existFeeds.append(existFeed)
                        }
                    }
                    self.updateModelView()
                    self.updateNewestFeeds()
                }
                self.EventsTableView.reloadData()
                self.updateScrollView()
                self.clearLoading()
            }
        }
        generalButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        generalButton.backgroundColor = UIColor.black
        generalButton.isEnabled = true
        researchButton.backgroundColor = #colorLiteral(red: 0.7848398089, green: 0.1659219265, blue: 0.1861632168, alpha: 1)
        researchButton.setTitleColor(.white, for: .normal)
        researchButton.isEnabled = false
        learningButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        learningButton.backgroundColor = UIColor.black
        learningButton.isEnabled = true
    }

    @IBAction func learningButtonTapped(_ sender: Any) {
        existFeeds.removeAll()
        newestFeeds.removeAll()
        self.showLoading()
        JsonManager.getEventsFeeds(department: "Learning") {feeds in
            DispatchQueue.main.async {
                if let feeds = feeds {
                    for existFeed in feeds {
                        if existFeed.deleted == false {
                            self.existFeeds.append(existFeed)
                        }
                    }
                    self.updateModelView()
                    self.updateNewestFeeds()
                }
                self.EventsTableView.reloadData()
                self.updateScrollView()
                self.clearLoading()
            }
        }
        generalButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        generalButton.backgroundColor = UIColor.black
        generalButton.isEnabled = true
        researchButton.setTitleColor(#colorLiteral(red: 0.7093815207, green: 0.1463209987, blue: 0.1024117991, alpha: 1), for: .normal)
        researchButton.backgroundColor = UIColor.black
        researchButton.isEnabled = true
        learningButton.backgroundColor = #colorLiteral(red: 0.7848398089, green: 0.1659219265, blue: 0.1861632168, alpha: 1)
        learningButton.setTitleColor(.white, for: .normal)
        learningButton.isEnabled = false
    }

    private func updateModelView() {
        existEvents.removeAll()
        for feed in existFeeds {
            existEvents.append(EventsViewModel(title: feed.title, content: feed.eventTagline, date: feed.createdDate, image: feed.imageurl))
        }
    }

    private func updateNewestFeeds() {
        if(self.existEvents.count >= 3) {
            self.newestFeeds.append(self.existEvents[0])
            self.newestFeeds.append(self.existEvents[1])
            self.newestFeeds.append(self.existEvents[2])
        } else {
            for index in 0..<self.existFeeds.count {
                self.newestFeeds.append(self.existEvents[index])
            }
        }
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
            imageView.image = newestFeeds[index].image

            //blur the background picture
            let regularBlur = UIBlurEffect(style: .regular)
            let blurView = UIVisualEffectView(effect: regularBlur)
            blurView.frame = imageView.bounds
            blurView.alpha = 0.6
            imageView.addSubview(blurView)

            tittleLabel.text = self.newestFeeds[index].title
            dateLabel.text = newestFeeds[index].date

            view.addSubview(imageView)
            view.addSubview(tittleLabel)
            view.addSubview(dateLabel)

            self.scrollView.addSubview(view)
        }
        self.scrollView.contentSize = CGSize(width: (self.scrollView.frame.size.width * CGFloat(self.newestFeeds.count)), height: self.scrollView.frame.size.height)
    }
}
