//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 25.10.21.
//

import UIKit
import Alamofire


class PopularViewController: UIViewController, UISearchResultsUpdating {
    
    var popular = [Movie]()
    var searchMovie = [Movie]()
    
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchMovieData()
        setupSearchController() 
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchMovie.removeAll(keepingCapacity: false)
        let array = popular.filter { result in
            guard let title = result.original_title else {return false}
            let fullTitle = title.lowercased()
            return fullTitle.contains(searchController.searchBar.text?.lowercased() ?? "")
        }
        searchMovie = array
        self.tableView.reloadData()
    }
    
    
    private func setupSearchController(){
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            self.definesPresentationContext = true
            controller.searchBar.barTintColor = UIColor.black
            controller.searchBar.backgroundColor = .white
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.definesPresentationContext = true
            if let textfield = controller.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor.white
                textfield.backgroundColor = .black
            }
            controller.dimsBackgroundDuringPresentation = false
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
        view.backgroundColor = .black
    }
    
    func fetchMovieData(){
        AF.request("https://api.themoviedb.org/3/movie/popular?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: MovieModel.self) { response in
            self.popular = response.value!.results ?? [Movie]()
            self.tableView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
}

extension PopularViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive {
            return searchMovie.count
        } else {
            return popular.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as! PopularCell
        
        if resultSearchController.isActive {
            cell.movieItem = searchMovie[indexPath.row]
        } else {
            cell.movieItem = popular[indexPath.row]
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopRatedDetailController") as! TopRatedDetailController
        
        if resultSearchController.isActive {
            vc.movieId = searchMovie[indexPath.row].id
        } else {
            vc.movieId = popular[indexPath.row].id
        }
        
        vc.isFromTV = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
