//
//  DeadLineViewModel.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 10/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation
import UIKit
class DeadLineViewModel {
    var title: String?
    var date: String
    var content: String?
    var image: UIImage
    var department: String

    init(title: String?,date: String, content: String?, image: UIImage, department: String) {
        self.title = title
        self.date = date
        self.content = content
        self.image = image
        self.department = department
    }
}
