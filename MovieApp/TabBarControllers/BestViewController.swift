//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 4.11.21.
//

import UIKit
import Alamofire

class BestViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var topThree: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var popularMovie = [Movie]()
    private var tvPopular = [TVDetailsModel]()
    
    var isFromTV = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchApi()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    private func fetchApi(){
        
        if isFromTV {
            fetchPopularTVShows()
            topThree.text = "Top 3 TV Shows ⬆️"
        } else{
            fetchPopularMovies()
            topThree.text = "Top 3 Movies ⬆️"
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    private func fetchPopularMovies(){
        AF.request("https://api.themoviedb.org/3/movie/popular?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: MovieModel.self) { response in
            
            if let responeMovie = response.value?.results {
                self.popularMovie = responeMovie
                self.tableView.reloadData()
            }
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
    
   private func fetchPopularTVShows(){
        AF.request("https://api.themoviedb.org/3/tv/popular?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: TVModel.self) { response in
            
            if let responeMovie = response.value?.results {
                self.tvPopular = responeMovie
                self.tableView.reloadData()
            }
            
            guard response.value == nil else {
                print("Something went wrong on fetchPopularAPI at TVViewController")
                return
            }
        }
    }
}

extension BestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        
        if isFromTV {
            cell.tvModel = tvPopular[indexPath.row]
        }else{
            cell.movieItem = popularMovie[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopRatedDetailController") as! TopRatedDetailController
        if isFromTV {
            vc.tvId = tvPopular[indexPath.row].id
            vc.isFromTV = true
        } else {
            vc.movieId = popularMovie[indexPath.row].id
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .systemBackground
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tvPopular.count != 0 || popularMovie.count != 0 {
            return 3
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
