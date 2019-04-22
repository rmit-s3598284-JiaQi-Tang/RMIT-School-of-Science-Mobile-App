//
//  JsonManager.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 22/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation

class JsonManager {

    typealias CompletionHandler = ([Feed]?) -> Void

    public static func getFeeds(completion: @escaping CompletionHandler) {
//        var feeds: [Feed] = []
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeeds?department=ALL&feedType=NEWS&index=0&size=10")
        if let unwrappedURL = fortniteChallengesURL {
            var request = URLRequest(url: unwrappedURL)
            request.addValue("1", forHTTPHeaderField: "userId")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // you should put in error handling code, too
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(Welcome.self, from: data) as Welcome
                        // HERE'S WHERE YOUR DATA IS
                        completion(json.feed)
//                        feeds = json.feed
//                        for loopFeed in json.feed {
//                            print(loopFeed.title)
//                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
//        for loopFeed in feeds {
//            print(loopFeed.title)
//        }
//        return feeds
    }
}
