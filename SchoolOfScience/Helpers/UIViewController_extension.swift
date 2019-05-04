//
//  UIViewController_extension.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 5/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func getPictureFromURL(url: String?) -> UIImage? {
        if let imageURL = url {
            let url = URL(string: imageURL)
            if let url = url {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    return UIImage(data: imageData)
                } else {
                    return UIImage.init(named: "rmit-building80")
                }
            } else {
                return UIImage.init(named: "rmit-building80")
            }
        } else {
            return UIImage.init(named: "rmit-building80")
        }
    }

    func getDateFromSeconds(seconds: Double) -> String {
        let timeInterval = seconds/1000
        let myDate = Date(timeIntervalSince1970: Double(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.string(from: myDate as Date)
    }

}
