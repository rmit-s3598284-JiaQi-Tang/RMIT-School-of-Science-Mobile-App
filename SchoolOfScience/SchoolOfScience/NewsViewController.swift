//
//  NewsViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.tittleLabel.text = "Welcome to School of Science"
        cell.tittleUIImage.image = UIImage.init(named: "rmit-building80")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(250)
    }

}
