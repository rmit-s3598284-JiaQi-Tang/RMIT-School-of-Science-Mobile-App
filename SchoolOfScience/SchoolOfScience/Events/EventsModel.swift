//
//  EventsModel.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation
import UIKit
class EventsModel {

    static var title: String = "Welcome to RMIT"
    static var content: String = "Nothing special mate"
    static var date: String = "01-Apr-2019"
    static var image: UIImage = UIImage(named: "rmit-building80")!

    // Shared Properties
    private static var sharedInstance: EventsModel = {
        let appModel = EventsModel()
        return appModel
    }()

    // Accessors
    class func shared() -> EventsModel {
        return sharedInstance
    }

    static func upDateDisplayingEvents(title: String, content: String, date: String, image: UIImage) {
        self.title = title
        self.content = content
        self.date = date
        self.image = image
    }
}
