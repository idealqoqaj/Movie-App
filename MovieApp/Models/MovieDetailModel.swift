//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 27.10.21.
//

import Foundation



struct MovieDetails: Decodable {
    var backdrop_path: String?
    var genres: [Genres]?
    var homepage: String
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String?
    var production_companies: [Production]?
    var release_date: String
    var revenue: Int
    var runtime: Int
    var status: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
    
}

struct Genres: Decodable {
    var id: Int
    var name: String
}

struct Production: Decodable {
    var id: Int
    var name: String
    var origin_country: String
}
