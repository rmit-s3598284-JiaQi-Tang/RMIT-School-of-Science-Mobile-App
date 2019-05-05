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
    typealias ContactsCompletionHandler = ([Contact]?) -> Void

    public static func getNewsFeeds(department: String, completion: @escaping CompletionHandler) {
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeeds?department=\(department)&feedType=NEWS&index=0&size=100")
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
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }

    public static func getEventsFeeds(department: String, completion: @escaping CompletionHandler) {
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeeds?department=\(department)&feedType=EVENTS&index=0&size=100")
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
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }

    public static func getContacts(completion: @escaping ContactsCompletionHandler) {
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getContacts?size=100&index=0")
        if let unwrappedURL = fortniteChallengesURL {
            var request = URLRequest(url: unwrappedURL)
            request.addValue("1", forHTTPHeaderField: "userId")
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                // you should put in error handling code, too
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(Welcome.self, from: data) as Welcome
                        // HERE'S WHERE YOUR DATA IS
                        completion(json.contacts)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }

    public static func getDeadLineFeeds(completion: @escaping CompletionHandler) {
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeeds?feedType=DEADLINES&index=0&size=100")
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
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }
}
