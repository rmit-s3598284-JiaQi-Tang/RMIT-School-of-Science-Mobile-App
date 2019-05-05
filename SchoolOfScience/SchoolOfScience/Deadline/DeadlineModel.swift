//
//  DeadlineModel.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation
import UIKit
class DeadlineModel {

    static var title: String = "Welcome to RMIT"
    static var content: String = "Nothing special mate"
    static var date: String = "01-Apr-2019"
    static var image: UIImage = UIImage(named: "rmit-building80")!

    // Shared Properties
    private static var sharedInstance: DeadlineModel = {
        let appModel = DeadlineModel()
        return appModel
    }()

    // Accessors
    class func shared() -> DeadlineModel {
        return sharedInstance
    }

    static func upDateDisplayingDeadline(title: String, content: String, date: String, image: UIImage) {
        self.title = title
        self.content = content
        self.date = date
        self.image = image
    }

}
