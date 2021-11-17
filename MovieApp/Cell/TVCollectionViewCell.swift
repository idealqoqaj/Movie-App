//
//  TVCollectionViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 3.11.21.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageTV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var tvImage: TVDetailsModel! {
        didSet {
            guard let unwrappedTVImg = tvImage else {return}
            if let imageUrl = unwrappedTVImg.backdrop_path {
                imageTV.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)"))
            }
        }
    }
    
    var tvImagePoster: TVDetailsModel!{
        didSet {
            guard let unwrappedTVPoster = tvImagePoster else {return}
            if let imageUrl = unwrappedTVPoster.poster_path {
                imageTV.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)"))
            }
        }
    }
}
