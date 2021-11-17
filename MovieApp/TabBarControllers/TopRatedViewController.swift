//
//  ExploreViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 25.10.21.
//

import UIKit
import Alamofire
import SwiftUI

class TopRatedViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var topRated = [Movie]()
    var movieIdSelected = 0
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchAPI()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopRatedDetailController") as! TopRatedDetailController
        
        if imageURL == "" {
            vc.movieId = topRated[0].id
        } else {
        vc.movieId = movieIdSelected
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 20
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? HeaderCollectionReusableView {
            if imageURL == "" {
                header.imageView.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500/5hNcsnMkwU2LknLoru73c76el3z.jpg"))
            } else {
            header.imageView.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)"))
            }
        }
    }
    
    func fetchAPI(){
        AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=d7a9b95d296376e5fe1942c0a53a5591", encoding: JSONEncoding.default).responseDecodable(of: MovieModel.self) { response in
          
            self.topRated = response.value?.results ?? [Movie]()
            self.collectionView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong")
                return
            }
        }
    }
}

extension TopRatedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRated.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCell", for: indexPath) as! TopRatedCell
        cell.movieItem = topRated[indexPath.row]
//        imageURL = topRated[0].backdrop_path ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.bounds.width/2-10, height: 211)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let detailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopRatedDetailController") as? TopRatedDetailController {
            detailController.movieId = topRated[indexPath.row].id
            movieIdSelected = topRated[indexPath.row].id
            imageURL = topRated[indexPath.row].backdrop_path ?? ""
            self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath)
                    as? HeaderCollectionReusableView else {
                        return UICollectionReusableView()
                    }
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            header.imageView.isUserInteractionEnabled = true
            header.imageView.addGestureRecognizer(tapGestureRecognizer)
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 1, bottom: 1, right: 1)
    }
}

