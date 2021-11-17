//
//  ThreeBestViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 5.11.21.
//

import UIKit

class ThreeBestViewController: UIViewController {
    
    @IBOutlet weak var topMovieBtn: UIButton!
    @IBOutlet weak var topTVBtn: UIButton!
    @IBOutlet weak var topActors: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topMovieBtn.layer.cornerRadius = 35
        topTVBtn.layer.cornerRadius = 35
        topActors.layer.cornerRadius = 35
    }
    
    @IBAction func top10Actors(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActorViewController") as! ActorViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func topMovies(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BestViewController") as! BestViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func topTVShows(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BestViewController") as! BestViewController
        vc.isFromTV = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
