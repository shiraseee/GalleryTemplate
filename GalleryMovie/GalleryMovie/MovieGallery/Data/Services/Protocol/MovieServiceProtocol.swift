//
//  MovieServiceProtocol.swift
//  GalleryMovie
//
//  Created by Michel Tan on 18/01/2025.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchMovies() -> AnyPublisher<[Movie],Error>
}
