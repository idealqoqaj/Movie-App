//
//  PopularCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 25.10.21.
//

import UIKit
import Kingfisher

class PopularCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var voteAVG: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 5
        movieImage.layer.cornerRadius = 40
    }
    
    var movieItem: Movie! {
        didSet {
            guard let unwrapMovieItem = movieItem else {return}
            titleMovie.text = unwrapMovieItem.title ?? ""
            voteAVG.text = "\(String(describing: unwrapMovieItem.vote_average))"
            if let backDropPath = unwrapMovieItem.backdrop_path {
                movieImage.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(backDropPath)"))
            }
        }
    }
}
