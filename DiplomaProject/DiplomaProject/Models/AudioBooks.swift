//
//  AudioBooks.swift
//  DiplomaProject
//
//  Created by Дарья Дубровская on 27.04.22.
//

import Foundation

// MARK: - Welcome
struct WelcomeAudioBooks: Codable {
    let feed: FeedAudioBooks
}

// MARK: - Feed
struct FeedAudioBooks: Codable {
    let title: String
    let id: String
    let author: AuthorAudioBooks
    let links: [LinkAudioBooks]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [ResultAudioBooks]
}

// MARK: - Author
struct AuthorAudioBooks: Codable {
    let name: String
    let url: String
}

// MARK: - Link
struct LinkAudioBooks: Codable {
    let linkSelf: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - Result
struct ResultAudioBooks: Codable {
    let artistName, id, name, releaseDate: String
    let kind: KindAudioBooks
    let artistID: String
    let artistURL: String
    let artworkUrl100: String
    let genres: [GenreAudioBooks]
    let url: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url
    }
}

// MARK: - Genre
struct GenreAudioBooks: Codable {
    let genreID, name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum KindAudioBooks: String, Codable {
    case audioBooks = "audio-books"
}
