//
//  ContentViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class NewsContentViewController: UIViewController {

    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var imageUIImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        tittleLabel.text = NewsModel.title
        dateLabel.text = NewsModel.date
        imageUIImageView.image = NewsModel.image
        contentTextView.text = NewsModel.content
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
