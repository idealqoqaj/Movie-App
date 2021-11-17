//
//  TVTableViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 3.11.21.
//

import UIKit
import Alamofire

class TVTableViewCell: UITableViewCell {
    
    var tvAiringToday = [TVDetailsModel]()
    var tvPopular = [TVDetailsModel]()
    var tvTopRated = [TVDetailsModel]()
    var tvOnTheAir = [TVDetailsModel]()
    
    weak var delegate: TableViewInCollectionViewDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        fetchAiringTodayAPI()
        fetchOnTheAirAPI()
        fetchTopRatedAPI()
        fetchPopularAPI()
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.reloadData()
    }
    
    func fetchAiringTodayAPI(){
        
        AF.request("https://api.themoviedb.org/3/tv/airing_today?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default, headers: HTTPHeaders.default).responseDecodable(of: TVModel.self) { response in
            self.tvAiringToday = response.value?.results ?? [TVDetailsModel]()
            self.collectionView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong on fetchLatestAPI at TVViewController")
                return
            }
        }
    }
    
    func fetchPopularAPI(){
        
        AF.request("https://api.themoviedb.org/3/tv/popular?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default, headers: HTTPHeaders.default).responseDecodable(of: TVModel.self) { response in
            self.tvPopular =  response.value?.results ?? [TVDetailsModel]()
            self.collectionView.reloadData()
            
            guard response.value == nil else {
                print("Something went wrong on fetchPopularAPI at TVViewController")
                return
            }
        }
    }
    
    func fetchTopRatedAPI(){
        
        AF.request("https://api.themoviedb.org/3/tv/top_rated?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default, headers: HTTPHeaders.default).responseDecodable(of: TVModel.self) { response in
            self.tvTopRated =  response.value?.results ?? [TVDetailsModel]()
            self.collectionView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong on fetchTopRatedAPI at TVViewController")
                return
            }
        }
    }
    
    func fetchOnTheAirAPI(){
        
        AF.request("https://api.themoviedb.org/3/tv/on_the_air?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default, headers: HTTPHeaders.default).responseDecodable(of: TVModel.self) { response in
            self.tvOnTheAir =  response.value?.results ?? [TVDetailsModel]()
            self.collectionView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong on fetchOnTheAirAPI at TVViewController")
                return
            }
        }
    }
}

extension TVTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
            
        case 0:
            return tvPopular.count
        case 1:
            return tvAiringToday.count
        case 2:
            return tvTopRated.count
        case 3:
            return tvOnTheAir.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
            
        case 0:
            let record = tvPopular[indexPath.row]
            delegate?.didSelectItem(model: record)
        case 1:
            let record1 = tvAiringToday[indexPath.row]
            delegate?.didSelectItem(model: record1)
        case 2:
            let record2 = tvTopRated[indexPath.row]
            delegate?.didSelectItem(model: record2)
        case 3:
            let record3 = tvOnTheAir[indexPath.row]
            delegate?.didSelectItem(model: record3)
            
        default:
            print("Something went wrong at didSelectItemAt of TVTableViewCell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TVCollectionViewCell
        cell.layer.cornerRadius = 40
        
        switch collectionView.tag {
            
        case 0:
            cell.tvImage = tvPopular[indexPath.row]
        case 1:
            cell.tvImagePoster = tvAiringToday[indexPath.row]
            cell.layer.cornerRadius = 10
        case 2:
            cell.tvImagePoster = tvTopRated[indexPath.row]
        case 3:
            cell.tvImage = tvOnTheAir[indexPath.row]
            
        default:
            print("Something went wrong at cellForItemAt TVTableViewCell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
            
        case 0:
            let size = CGSize(width: self.collectionView.bounds.width, height: 250)
            return size
        case 1:
            let size = CGSize(width: self.collectionView.bounds.width/3 - 5, height: 100)
            return size
        case 2:
            let size = CGSize(width: self.collectionView.bounds.width/2 - 10, height: 200)
            return size
        case 3:
            let size = CGSize(width: self.collectionView.bounds.width, height: 250)
            return size
            
        default:
            return CGSize()
        }
    }
}

extension TVTableViewCell: TableViewInCollectionViewDelegate{
    func didSelectItem(model: TVDetailsModel) {
        delegate?.didSelectItem(model: model)
    }
}
