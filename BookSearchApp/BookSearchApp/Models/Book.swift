//
//  Book.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ResponseData: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let resultNum: Int?
    let docs: [BookData]
}

// MARK: - DocElement
struct BookData: Codable {
    let doc: Book?
}

// MARK: - DocDoc
struct Book: Codable {
    let ranking, title, authors, publisher: String?
    let isbn: String?
    let bookImageURL: String?

    enum CodingKeys: String, CodingKey {
        case ranking, authors, publisher, bookImageURL
        case title = "bookname"
        case isbn = "isbn13"
    }
}

