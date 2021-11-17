//
//  TVViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 2.11.21.
//

import UIKit
import Alamofire

class TVViewController: UIViewController {
    
    var tvAiringToday = [TVDetailsModel]()
    var tvPopular = [TVDetailsModel]()
    var tvTopRated = [TVDetailsModel]()
    var tvOnTheAir = [TVDetailsModel]()
    
    var titleTVheader = ["Popular", "TV Airing Today", "Top Rated", "On the Air"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleTVheader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.tvPopular = tvPopular
        case 1:
            cell.tvAiringToday = tvAiringToday
        case 2:
            cell.tvTopRated = tvTopRated
        case 3:
            cell.tvOnTheAir = tvOnTheAir
        default:
            print("Something went wrong on cellForRowAt TVViewController")
            
        }
        
        cell.delegate = self
        cell.collectionView.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0 :
            return 300
        case 1:
            return 140
        case 2:
            return 250
        case 3:
            return 300
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = UILabel()
        title.text = titleTVheader[section]
        title.font = UIFont(name: "Charter", size: 18)
        title.textColor = .white
        
        return title.text
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension TVViewController: TableViewInCollectionViewDelegate {
    
        func didSelectItem(model: TVDetailsModel) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: "TopRatedDetailController") as? TopRatedDetailController {
            detailVC.isFromTV = true
            detailVC.tvId = model.id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


