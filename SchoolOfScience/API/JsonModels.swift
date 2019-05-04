//
//  JsonModels.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 22/4/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let code: Int
    let message: String
    let feed: [Feed]
    let size: Int
}

struct Feed: Codable {
    let feedID: String
    let createdDate: Double
    let news: String?
    let authorID: AuthorID
    let title: String?
    let department: Department
    let updatedDate: Double
    let category: Category
    let deadlineDate: Double?
    let eventTagline: String?
    let sendNotification: Bool
    let imageurl: String?
    let deleted: Bool

    enum CodingKeys: String, CodingKey {
        case feedID = "feedId"
        case createdDate, news
        case authorID = "authorId"
        case title, department, updatedDate, category, deadlineDate, eventTagline, sendNotification, imageurl, deleted
    }
}

enum AuthorID: String, Codable {
    case testUser1RmitEduAu = "test.user1@rmit.edu.au"
}

enum Category: String, Codable {
    case deadlines = "DEADLINES"
    case events = "EVENTS"
    case news = "NEWS"
}

enum Department: String, Codable {
    case all = "ALL"
    case general = "GENERAL"
    case learning = "LEARNING"
    case research = "RESEARCH"
}
