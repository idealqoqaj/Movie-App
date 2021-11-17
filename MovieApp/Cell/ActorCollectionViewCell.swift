//
//  ActorCollectionViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 9.11.21.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageActor: UIImageView!
    @IBOutlet weak var nameOfActor: UILabel!
    
    var actorItem: ActorResults! {
        didSet{
            guard let unwrappedActor = actorItem else {return}
            if let imageUrl = unwrappedActor.profile_path {
                imageActor.setImage(url: URL(string:"https://image.tmdb.org/t/p/w500\(imageUrl)"))
            }
            nameOfActor.text = unwrappedActor.name
        }
    }
}
