//
//  JsonManager.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 22/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation

class APIManager {

    typealias CompletionHandler = ([Feed]?) -> Void
    typealias ContactsCompletionHandler = ([Contact]?) -> Void

    public static func login(username: String, password: String, completion: @escaping CompletionHandler) {
        let fortniteChallengesURL = URL(string: "https://rmit-gateway.herokuapp.com/authenticate?username=s3598284@student.rmit.edu.au&password=t4908866")
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

    public static func getNewsFeeds(department: String, completion: @escaping CompletionHandler) {
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeedsforMobile?department=\(department)&feedType=NEWS")
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
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeedsforMobile?department=\(department)&feedType=EVENTS")
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
        let fortniteChallengesURL = URL(string: "https://rmit-engine.herokuapp.com/student/getFeedsforMobile?feedType=DEADLINES")
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

    public static func login(username: String, password: String) {
        let credential = URLCredential(user: "test.user1@rmit.edu.au", password: "password", persistence: URLCredential.Persistence.forSession)
        let protectionSpace = URLProtectionSpace(host: "rmit-gateway-test.herokuapp.com", port: 443, protocol: "https", realm: "Restricted", authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let url = URL(string: "https://rmit-gateway-test.herokuapp.com/authenticate?\(username)&password=\(password)")!

        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            print(String(data: data!, encoding: .utf8)!)
        }

        task.resume()
    }
}
