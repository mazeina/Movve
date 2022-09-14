//
//  MovieModel.swift
//  Movve
//
//  Created by Полина Дусин on 07.09.2022.
//

import Foundation

struct MovieModel {
    let movieName: String
    let imagePath: String
    let releaseData: String
    
    init(movie: ResponseMovie) {
        movieName = movie.title
        imagePath = movie.posterPath
        releaseData = movie.releaseDate
    }
}

struct MoviesList {
    let list: [MovieModel]
    
    init(movies: [ResponseMovie]) {
        var result = [MovieModel]()
        
        for movie in movies {
            result.append(MovieModel(movie: movie))
        }
        
        list = result
    }
}
