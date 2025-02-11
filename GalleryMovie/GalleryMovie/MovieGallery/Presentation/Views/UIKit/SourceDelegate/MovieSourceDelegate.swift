//
//  MovieSourceDelegate.swift
//  GalleryMovie
//
//  Created by Michel Tan on 28/01/2025.
//

import Foundation
import UIKit

public extension UICollectionView {
    /// Sugar method to register nib cell identified by its holding class.
    /// The UICollectionViewCell subclass must have the same name than the corresponding xib
    ///
    /// - Parameter cellClass: the UICollectionViewCell subclass
    /// - SeeAlso: `func register(_ nib: UINib?, forCellReuseIdentifier identifier: String)`
    func registerCellNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func registerHeaderNib<T: UICollectionReusableView>(_ cellClass: T.Type, kind: String) {
        let identifier = className(cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
    
    /// Sugar method to register the given *cellClass* cell (no xib)
    ///
    /// - Parameter cellClass: the UICollectionViewCell subclass
    func registerCellClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let identifier = className(cellClass)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    /// Sugar method to dequeue reusable cell by class
    ///
    /// - Parameters:
    ///   - viewClass: the UICollectionViewCell subclass
    ///   - indexPath: The index path specifying the location of the cell. Always specify the index path provided to you by your data source object.
    /// This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
    /// - Returns: A `UICollectionViewCell` object with the associated reuse identifier.
    func dequeueReusableCell<T: UICollectionViewCell>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = className(viewClass)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T // swiftlint:disable:this force_cast
    }
    
    private func className(_ aClass: AnyClass) -> String {
        return String(describing: aClass)
    }
}


protocol IMovieSourceDelegate : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
}

class MovieSourceDelegate: NSObject, IMovieSourceDelegate {
    private let viewModel : MovieViewModel
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

extension MovieSourceDelegate : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(MovieCollectionViewCell.self, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("unable to dequeue MovieCollectionViewCell")
        }
        let movie : Movie
        switch indexPath.section {
        case 0:
            movie = viewModel.listMoviePopular[indexPath.row]
        case 1:
            movie = viewModel.listCurrentMovie[indexPath.row]
        default:
            movie = viewModel.listCurrentMovie[indexPath.row]
        }
        cell.configure(movie: movie)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 //pour l'instant 2 sections definies.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel.listMoviePopular.count
        case 1: return viewModel.listCurrentMovie.count
        default: return 0
        }
    }
}
