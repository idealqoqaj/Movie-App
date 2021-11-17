//
//  TopRatedDetailController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 28.10.21.
//

import UIKit
import Alamofire
import SDWebImage
import StoreKit

class TopRatedDetailController: UIViewController, UIGestureRecognizerDelegate {
    
    var movieDetails: MovieDetails!
    var tvDetails: TVDetailsModel!
    var videoModel: VideoModel!
    var movieId = 0
    var tvId = 0
    var isFromTV = false
    var video: Video!
    var videoURL = ""
    
    var controller = UIViewController()
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var landscapeImage: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var productionCompanies: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var squareImage: UIImageView!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var voteAVG: UILabel!
    @IBOutlet weak var youtube: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPI()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func fetchAPI(){
        view.backgroundColor = .black
        
        if isFromTV {
            fetchTVApi()
            fetchAPIForTVThumbnail()
        } else {
            fetchMovieAPI()
            fetchAPIforMovieThumbnail()
        }
        
        
        overview.backgroundColor = .black
        overview.isEditable = false
    }
    
    @IBAction func playVideo(_ sender: Any) {
        playVideo()
    }
    
    func playVideo() {
        
        if let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as? WebViewController{
            if isFromTV {
                webVC.tvYoutubeId = tvDetails.id
                webVC.isFromTV = true
            } else {
                webVC.youtubeId = movieDetails.id
            }
            self.present(webVC, animated: true, completion: nil)
        }
    }
    
    func getThumbnail(){
        
        var keyString = ""

        if let firstResult = video.results?.first, let firstKey = firstResult.key {
            keyString = "\(firstKey)"
        }
        
        let url = URL(string: "https://img.youtube.com/vi/\(keyString)/0.jpg")
        
        youtube.sd_setImage(with: url!, placeholderImage: UIImage(named: ""))
    }
    
    func fetchAPIforMovieThumbnail(){
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: Video.self) { response in
            self.video = response.value
            self.getThumbnail()
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
    
    func fetchAPIForTVThumbnail(){
        
        AF.request("https://api.themoviedb.org/3/tv/\(tvId)/videos?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: Video.self) { response in
            self.video = response.value
            self.getThumbnail()
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
    
    func fetchTVApi(){
        
        AF.request("https://api.themoviedb.org/3/tv/\(tvId)?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: TVDetailsModel.self) { response in
            
            self.tvDetails = response.value
            self.setupUIForTV()
            
            guard response.error == nil else {
                print("Something went wrong on fetchTVApi ine TopRatedDetailController")
                return
            }
        }
    }
    
    func fetchMovieAPI(){
        AF.request("https://api.themoviedb.org/3/movie/\(movieId)?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: MovieDetails.self) { response in
            
            self.movieDetails = response.value
            self.setupUIforMovie()
            
            guard response.error == nil else {
                print("Something went wrong at MovieId")
                return
            }
        }
    }
    
    @IBAction func rateMovie(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RateViewController") as! RateViewController
        
        if isFromTV {
            vc.tvId = tvDetails.id
        } else {
            vc.movieId = movieDetails.id
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func setupUIforMovieDetails(_ genreString: String, _ productionString: String) {
        let landscapeImgURL = "https://image.tmdb.org/t/p/w500\(movieDetails.backdrop_path ?? "")"
        let squareImgURL = "https://image.tmdb.org/t/p/w500\(movieDetails.poster_path ?? "")"
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let date = dateformatter.date(from: movieDetails.release_date)
        let time = dateformatter.string(from: date ?? Date())
        
        genre.text = "\(genreString)"
        productionCompanies.text = "\(productionString)"
        createdAt.text = time
        landscapeImage.setImage(url: URL(string: landscapeImgURL))
        squareImage.setImage(url: URL(string: squareImgURL))
        overview.text = movieDetails.overview
        voteAVG.text = "\(movieDetails.vote_average)"
        titleMovie.text = movieDetails.title
//        let videoUrl = movieDetails.
    }
    
    func setupUIforMovie(){
        
        var genreString = ""
        var firstGener = true
        
        var productionString = ""
        var firstProduction = true
        
        for genre in movieDetails.genres! {
            if firstGener {
                genreString += "\(genre.name)"
                firstGener = false
            } else {
                genreString += ", \(genre.name)"
            }
        }
        
        for production in movieDetails.production_companies! {
            
            if firstProduction {
                productionString += "\(production.name)"
                firstProduction = false
            } else {
                productionString += ", \(production.name)"
            }
        }
        setupUIforMovieDetails(genreString, productionString)
    }
    
    fileprivate func setupUIForTVDetails(_ genreString: String, _ createdByString: String) {
        let landscapeImgURL = "https://image.tmdb.org/t/p/w500\(tvDetails.backdrop_path ?? "")"
        let squareImgURL = "https://image.tmdb.org/t/p/w500\(tvDetails.poster_path ?? "")"
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let date = dateformatter.date(from: tvDetails.first_air_date ?? "")
        let time = dateformatter.string(from: date ?? Date())
        
        genre.text = "\(genreString)"
        productionCompanies.text = "\(createdByString)"
        createdAt.text = time
        landscapeImage.setImage(url: URL(string: landscapeImgURL))
        squareImage.setImage(url: URL(string: squareImgURL))
        overview.text = tvDetails.overview
        voteAVG.text = "\(String(describing: tvDetails.vote_average))"
        titleMovie.text = tvDetails.original_name
    }
    
    func setupUIForTV() {
        
        var genreString = ""
        var firstGener = true
        
        var createdByString = ""
        var firstCreatedBy = true
        
        for genre in tvDetails.genres! {
            if firstGener {
                genreString += "\(String(describing: genre.name))"
                firstGener = false
            } else {
                genreString += ", \(String(describing: genre.name))"
            }
        }
        
        for createdBy in tvDetails.created_by! {
            if firstCreatedBy {
                createdByString += "\(createdBy.name)"
                firstCreatedBy = false
            }else{
                createdByString += ", \(createdBy.name)"
            }
        }
        setupUIForTVDetails(genreString, createdByString)
    }
}
