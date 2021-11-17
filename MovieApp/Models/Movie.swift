//
//  Models.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 25.10.21.
//

import Foundation

struct MovieModel: Codable {
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}

struct Movie: Codable, Hashable {
    var id: Int
    var original_language: String?
    var genre_ids: [Int]?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double
    var vote_count: Int?
    var adult: Bool?
    var backdrop_path: String?
}
