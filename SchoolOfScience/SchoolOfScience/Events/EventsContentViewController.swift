//
//  EventsContentViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class EventsContentViewController: UIViewController {

    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var imageUIImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        tittleLabel.text = EventsModel.title
        dateLabel.text = EventsModel.date
        imageUIImageView.image = EventsModel.image
        contentTextView.attributedText = NSAttributedString(string: EventsModel.content)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
