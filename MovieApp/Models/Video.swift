//
//  VideoModel.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 28.10.21.
//

import Foundation


struct Video: Decodable {
    var id: Int?
    var results: [VideoModel]?
}

struct VideoModel: Decodable {
    var name: String?
    var key: String?
    var id: String? 
}
