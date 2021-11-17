//
//  TVModel.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 2.11.21.
//

import Foundation


struct TVModel: Codable {
    var page: Int?
    var results: [TVDetailsModel]?
    var total_pages: Int?
    var total_results: Int?
    
}
struct TVDetailsModel: Codable{
    var backdrop_path: String?
    var first_air_date: String?
    var homepage: String?
    var id: Int
    var in_production: Bool?
    var last_air_date: String?
    var name: String?
    var number_of_episodes: Int?
    var number_of_seasons: Int?
    var original_language: String?
    var original_name: String
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var status: String?
    var type: String?
    var vote_average: Double
    var vote_count: Int?
    var created_by: [CreatedBy]?
    var genres: [GenresOfTV]?
}


struct CreatedBy: Codable {
    var id: Int
    var name: String
}

struct GenresOfTV: Codable{
    var id: Int
    var name: String
}

