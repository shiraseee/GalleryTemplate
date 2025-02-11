//
//  FetchMoviesUseCase.swift
//  GalleryMovie
//
//  Created by Michel Tan on 18/01/2025.
//

import Foundation
import Combine

class FetchMoviesUseCase {
    
    private let movieService : MockMovieService
    
    init(movieService: MockMovieService) {
        self.movieService = movieService
    }
    
    func fetchMovies() -> AnyPublisher<[Movie],Error> {
        self.movieService.fetchMovies()
    }
}
