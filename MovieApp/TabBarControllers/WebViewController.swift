//
//  WebViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 28.10.21.
//

import UIKit
import WebKit
import Alamofire

class WebViewController: UIViewController {
    
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var noTrailer: UILabel!
    
    var video: Video!
    var youtubeId = 0
    var tvYoutubeId = 0
    
    var isFromTV = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPI()
    }
    
    func fetchAPI(){
        if isFromTV {
            fetchAPIForTV()
        } else {
            fetchAPIforMovie()
        }
    }
    
    func play(){
        
        var keyString = ""
        
        for key in video.results!{
            keyString += "\(key.key ?? "")"
        }
        
        if keyString == "" {
            noTrailer.text = "This Movie Has No Trailer \n Swipe Down"
            noTrailer.textAlignment = .center
        }else{
            playVideo(videoCode: keyString)
        }
    }
    
    func playVideo(videoCode: String){
        let url = URL(string: "https://www.youtube.com/watch/\(videoCode)")
        myWebView.load(URLRequest(url: url!))
    }
    
    func fetchAPIforMovie(){
        
        AF.request("https://api.themoviedb.org/3/movie/\(youtubeId)/videos?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: Video.self) { response in
            self.video = response.value
            self.play()
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
    
    func fetchAPIForTV(){
        
        AF.request("https://api.themoviedb.org/3/tv/\(tvYoutubeId)/videos?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: Video.self) { response in
            self.video = response.value
            self.play()
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
}
