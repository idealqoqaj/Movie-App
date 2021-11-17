//
//  RateViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 2.11.21.
//

import UIKit
import Cosmos
import TinyConstraints
import Alamofire

class RateViewController: UIViewController {
    
    private var rateValue : Double = 0.0
    var movieId = 0
    var tvId = 0
    var isFromTV = false
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        
        view.settings.filledImage = UIImage(named: "RatingStarFilled")?.withRenderingMode(.alwaysOriginal)
        view.settings.emptyImage = UIImage(named: "RatingStarEmpty")?.withRenderingMode(.alwaysOriginal)
        view.settings.totalStars = 10
        view.settings.starSize = 17
        view.settings.starMargin = 3.3
        view.settings.fillMode = .half
        view.settings.textFont = UIFont(name: "Charter", size: 18)!
        view.settings.textColor = .white
        view.settings.textMargin = 10
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCosmoView()
    }
    
    func setupCosmoView(){
        view.addSubview(cosmosView)
        cosmosView.centerInSuperview()
        
        cosmosView.didTouchCosmos = { rating in
            self.rateValue = rating
            print("Rate value", self.rateValue)
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if isFromTV {
            fetchMovieAPI()
        } else {
            fetchTVAPI()
        }
    }
    
    func fetchTVAPI(){
        
        let parammeters = ["value": rateValue]
        
        AF.request("https://api.themoviedb.org/3/tv/\(tvId)/rating?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .post, parameters: parammeters, encoding: JSONEncoding.default).responseJSON { response in
            self.navigationController?.popViewController(animated: true)
            
            guard response.error == nil else {
                print("Something went wrong on sending the value of API at Rating movie")
                return
            }
        }
    }
    
    func fetchMovieAPI(){
        
        let parammeters = ["value": rateValue]
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieId)/rating?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .post, parameters: parammeters, encoding: JSONEncoding.default).responseJSON { response in
            self.navigationController?.popViewController(animated: true)
            
            guard response.error == nil else {
                print("Something went wrong on sending the value of API at Rating movie")
                return
            }
        }
    }
}
