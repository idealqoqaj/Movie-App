//
//  TopRatedCollectionViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 27.10.21.
//

import UIKit

class TopRatedCell: UICollectionViewCell {
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var voteAVG: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var movieItem: Movie! {
        didSet {
            guard let unwrapMovieItem = movieItem else {return}
            titleMovie.text = unwrapMovieItem.title
            voteAVG.text = "\(String(describing: unwrapMovieItem.vote_average))"
            if let imageURL =  unwrapMovieItem.backdrop_path {
                imageMovie.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)"))
            }
        }
    }
}
