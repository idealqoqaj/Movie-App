//
//  NotificationViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 25.10.21.
//

import UIKit
import Alamofire
import CloudKit

protocol CustomDelegate: AnyObject {
    func didSelectItem(record: CKRecord)
}

class UpComingViewController: UIViewController {
    
    var upcomingMovie = [Movie]()
    var nowPlaying = [Movie]()
    var titleHeader = ["Upcoming Movie", "Now Playing"]
    
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}


extension UpComingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 1:
            return 250
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleHeader[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleHeader.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.upcomingMovie = upcomingMovie
        case 1:
            cell.nowPlaying = nowPlaying
        default:
            print("nothing")
        }
        
        cell.delegate = self
        cell.collectionView.tag = indexPath.section
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
    }
}

extension UpComingViewController: TableViewInsideCollectionViewDelegate {
    func didSelectItem(model: Movie) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: "TopRatedDetailController") as? TopRatedDetailController {
            detailVC.movieId = model.id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


