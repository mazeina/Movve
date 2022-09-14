//
//  MovieModel.swift
//  Movve
//
//  Created by Полина Дусин on 07.09.2022.
//

import Foundation

struct ResponseMovies: Codable {
    let results: [ResponseMovie]
}

struct ResponseMovie: Codable {
    let title: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
