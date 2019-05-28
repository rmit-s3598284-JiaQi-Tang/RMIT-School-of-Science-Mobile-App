//
//  DeadlineContentViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class DeadlineContentViewController: UIViewController {

    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var imageUIImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        tittleLabel.text = DeadlineModel.title
        dateLabel.text = DeadlineModel.date
        imageUIImageView.image = DeadlineModel.image
        contentTextView.text = DeadlineModel.content
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
