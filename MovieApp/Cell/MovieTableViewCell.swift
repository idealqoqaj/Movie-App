//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 29.10.21.
//

import UIKit
import Alamofire
import CloudKit


protocol TableViewInsideCollectionViewDelegate: AnyObject {
    func didSelectItem(model: Movie)
}

protocol TableViewInCollectionViewDelegate: AnyObject {
    func didSelectItem(model: TVDetailsModel)
}

class MovieTableViewCell: UITableViewCell {
    
    var upcomingMovie = [Movie]()
    var nowPlaying = [Movie]()
    
    weak var delegate: TableViewInsideCollectionViewDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchUpcomingAPI()
        fetchNowPlayingAPI()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        collectionView.tag = 2
        self.collectionView.reloadData()
    }
    
    func fetchUpcomingAPI(){
        
        AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default, headers: HTTPHeaders.default).responseDecodable(of: MovieModel.self) { response in
            self.upcomingMovie = response.value?.results ?? [Movie]()
            self.collectionView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong on Upcoming API")
                return
            }
        }
    }
    
    func fetchNowPlayingAPI(){
        
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default, headers: HTTPHeaders.default).responseDecodable(of: MovieModel.self) { response in
            self.nowPlaying = response.value?.results ?? [Movie]()
            self.collectionView.reloadData()
            
            guard response.value == nil else {
                print("Something went wrong on Now Playing API")
                return
            }
        }
    }
}

extension MovieTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return upcomingMovie.count
        case 1:
            return nowPlaying.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 0:
            let record = upcomingMovie[indexPath.row]
            delegate?.didSelectItem(model: record)
        case 1:
            let record1 = nowPlaying[indexPath.row]
            delegate?.didSelectItem(model: record1)
            
        default:
            print("Something went wrong at didSelectItemAt ne CollectionView")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            cell.movieItem = upcomingMovie[indexPath.row]
        case 1:
            cell.movieItem = nowPlaying[indexPath.row]
            
        default:
            print("Something went wrong on cellForItemAt")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.bounds.width/2 - 20, height: 210)
        return size
    }
}

extension MovieTableViewCell: TableViewInsideCollectionViewDelegate{
    func didSelectItem(model: Movie) {
        delegate?.didSelectItem(model: model)
    }
}

