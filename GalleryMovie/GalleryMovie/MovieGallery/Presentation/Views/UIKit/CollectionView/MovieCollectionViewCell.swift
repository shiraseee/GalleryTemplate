//
//  MovieCollectionViewCell.swift
//  GalleryMovie
//
//  Created by Michel Tan on 28/01/2025.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder: NSCoder) {
        //fatalError("init error")
        super.init(coder: coder)
    }
    
    func configure(movie : Movie) {
        //movie.title
    }
}
