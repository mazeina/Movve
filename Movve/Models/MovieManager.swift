//
//  MovieManager.swift
//  Movve
//
//  Created by Полина Дусин on 07.09.2022.
//

import Foundation
import UIKit

protocol MovieManagerDelegate {
    // Получение данных о фильме
    func didUpdateMovies(movies: [MovieModel])
    // Выбрасывание ошибок
    func didFailWithError(error: Error)
}

protocol MovieManagerImageDelegate {
    // Загрузка картинки
    func didLoadImage(with: UIImage)
    // Выбрасывание ошибок
    func didFailWithError(error: Error)
}

struct MovieManager {
    private let dataBaseURL = "https://api.themoviedb.org/3/movie/popular"
    private let imageURL = "https://www.themoviedb.org/t/p/w440_and_h660_face"
    private let apiKey = "53a3ab9ad5306c9b4e0d2ad8fd531b0d"
    
    var delegate: MovieManagerDelegate?
    var delegateImage: MovieManagerImageDelegate?
    
    func getPopularMovie() {
        let urlString = "\(dataBaseURL)?api_key=\(apiKey)"
        
        performRequest(with: urlString)
        print("\(urlString)")
    }
    
    func getImageByPath(imagePath: String) {
        let url = URL(string: imageURL + imagePath)
        
        if let data = try? Data(contentsOf: url!) {
            if let image = UIImage(data: data) {
                delegateImage?.didLoadImage(with: image)
            }
        }
    }
    
    // Выполнение запроса
    private func performRequest(with urlString: String) {
        // 1. Создание URL объекта
        if let url = URL(string: urlString) {
            // 2. Создание URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Дать URL-сессии задачу.
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let movies = self.parseJSON(movieData: safeData) {
                        self.delegate?.didUpdateMovies(movies: movies)
                        print("do safeData")
                    }
                }
            }
            
            // 4. Начать выполнение задачи.
            task.resume()
        }
    }
    
    private func parseJSON(movieData: Data) -> [MovieModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseMovies.self, from: movieData)
            print("do parseJSON")
            
            let movieList = MoviesList(movies: decodedData.results)
            
            return movieList.list
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
