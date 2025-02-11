//
//  Movie.swift
//  GalleryMovie
//
//  Created by Michel Tan on 18/01/2025.
//

import Foundation

struct Movie: Identifiable, Codable {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String,CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
