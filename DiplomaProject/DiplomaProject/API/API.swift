//
//  API.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 24.04.22.
//

import Foundation

class ApiBooks {
    static let serverPath = "https://rss.applemarketingtools.com/api/v2/us/books/top-free/10/books.json"
    static let booksPath = serverPath + "books"
    static let booksPathURL = URL(string: booksPath)
    static let remoteBooksUrl = URL (string: "https://rss.applemarketingtools.com/api/v2/us/books/top-free/10/books.json")
    static let remoteAudioBooksUrl = URL (string: "https://rss.applemarketingtools.com/api/v2/us/audio-books/top/10/audio-books.json")
    static let remoteBookBuyUrl = URL (string: "All data at this location will be overwritten")
//    static let remotePoemsUrl = URL (string: "https://www.poemist.com/api/v1/randompoems")
}
