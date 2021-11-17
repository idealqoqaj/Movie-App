//
//  HeaderCollectionReusableView.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 8.11.21.
//

import UIKit
import Alamofire

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    var movieDetails: MovieDetails!
    var movieId = 0
    
    public var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "movieImg"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
