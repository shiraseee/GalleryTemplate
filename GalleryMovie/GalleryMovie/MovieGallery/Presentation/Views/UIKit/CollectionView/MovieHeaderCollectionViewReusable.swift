//
//  MovieHeaderCollectionViewReusable.swift
//  GalleryMovie
//
//  Created by Michel Tan on 06/02/2025.
//

import Foundation
import UIKit

class MovieHeaderCollectionViewReusable : UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(title : String) {
        titleLabel.text = title
    }
}
