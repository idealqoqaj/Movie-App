//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 29.10.21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    var movieItem: Movie! {
        didSet{
            guard let unwrappedImage = movieItem else {return}
            if let imageUrl = unwrappedImage.poster_path{
                image.setImage(url: URL(string:"https://image.tmdb.org/t/p/w500\(imageUrl)"))
            }
        }
    }
}
