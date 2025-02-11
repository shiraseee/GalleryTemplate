//
//  MovieViewModel.swift
//  GalleryMovie
//
//  Created by Michel Tan on 26/01/2025.
//

import Foundation
import Combine

class MovieViewModel : ObservableObject {
    
    private let fetchMovieUseCase : FetchMoviesUseCase
    @Published var listCurrentMovie : [Movie] = []
    @Published var listMoviePopular : [Movie] = []
    
    var cancellables = Set<AnyCancellable>()
    //callback manual
    var onMoviesUpdated: (() -> Void)?
    
    init(fetchMovieUseCase: FetchMoviesUseCase) {
        self.fetchMovieUseCase = fetchMovieUseCase
    }
    /*
        func sink(
         receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
         receiveValue: @escaping (Self.Output) -> Void
        ) -> AnyCancellable
     */
    func getFetchMovie() {
        self.fetchMovieUseCase.fetchMovies()
            .sink { completion in
                switch completion {
                case .finished:
                    print("success")
                case .failure(let error):
                    print("error =\(error)")
                }
            } receiveValue: { movies in
                self.listCurrentMovie = movies
                self.listMoviePopular = movies//@TODO query specific
                //self.onMoviesUpdated?()  // notifier
            }
            .store(in: &cancellables)
    }
}
