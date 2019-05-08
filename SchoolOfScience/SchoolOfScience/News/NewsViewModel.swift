//
//  NewsViewModel.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 9/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation
import UIKit
class NewsViewModel {
    var title: String?
    var content:String?
    var date: String
    var image: UIImage

    init(title: String?,content:String?, date: Int, image: String?) {
        self.title = title
        self.content = content
        self.date = UIViewController.getDateFromSeconds(seconds: date)
        self.image = UIViewController.getPictureFromURL(url: image)!
    }
}
