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
    let createdDate: Int
    let news: String?
    let authorID: AuthorID
    let title: String?
    let department: String
    let updatedDate: Int
    let category: Category
    let deadlineDate, eventTagline: JSONNull?
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
    case news = "NEWS"
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
