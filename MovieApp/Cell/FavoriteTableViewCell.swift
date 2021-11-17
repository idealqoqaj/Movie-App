//
//  FavoriteTableViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 5.11.21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var genreOfMovie: UILabel!
    @IBOutlet weak var averageMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageMovie.layer.cornerRadius = 20
        cellView.layer.cornerRadius = 20
    }
    
    var movieItem: Movie! {
        didSet {
            guard let unwrappedMovie = movieItem else {return}
            
            if let imageUrl = unwrappedMovie.backdrop_path {
                imageMovie.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)"))
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            
            let year = dateFormatter.date(from: unwrappedMovie.release_date ?? "")
            let yearDate = dateFormatter.string(from: year ?? Date())
            
            genreOfMovie.text = yearDate
            titleMovie.text = unwrappedMovie.title
            averageMovie.text = "\(String(describing: unwrappedMovie.vote_average))"
        }
    }
    
    var tvModel: TVDetailsModel! {
        didSet {
            guard let unwrappedTV = tvModel else {return}
            if let imageUrl = unwrappedTV.backdrop_path {
                imageMovie.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)"))
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            
            let year = dateFormatter.date(from: unwrappedTV.first_air_date ?? "")
            let yearDate = dateFormatter.string(from: year ?? Date())
            
            genreOfMovie.text = yearDate
            titleMovie.text = unwrappedTV.name
            averageMovie.text = "\(unwrappedTV.vote_average)"
        }
    }
}
