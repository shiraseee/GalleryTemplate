//
//  MockMovieService.swift
//  GalleryMovie
//
//  Created by Michel Tan on 18/01/2025.
//

import Foundation
import Combine

class MockMovieService: MovieServiceProtocol {
    func fetchMovies() -> AnyPublisher<[Movie], any Error> {
        //Mock data : list movie
        let mockMovies = [
            Movie(id: 1, title: "Inception", overview: "A mind-bending thriller", posterPath: nil, releaseDate: "2010-07-16"),
            Movie(id: 2, title: "Interstellar", overview: "A journey through space and time", posterPath: nil, releaseDate: "2014-11-07"),
            Movie(id: 3, title: "The Dark Knight", overview: "A hero emerges in Gotham City", posterPath: nil, releaseDate: "2008-07-18")
        ]
        // Simulate network delay
        return Just(mockMovies)
            .delay(for: .seconds(1), scheduler: DispatchQueue.global())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
