//
//  ActorModel.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 9.11.21.
//

import Foundation

struct ActorModel: Decodable {
    var page: Int
    var results: [ActorResults]?
}

struct ActorResults: Decodable, Hashable {
    var gender: Int?
    var id: Int?
    var known_for_department: String?
    var name: String?
    var profile_path: String?
}

struct ActorDetail: Decodable {
    var biography: String?
    var birthday: String?
    var gender: Int?
    var id: Int?
    var known_for_department: String?
    var name: String?
    var place_of_birth: String?
    var profile_path: String?
}
