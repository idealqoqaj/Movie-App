//
//  ActorViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 9.11.21.
//

import UIKit
import Alamofire

class ActorViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var actorInfo = [ActorResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchActorAPI()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 20
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
    }
    
    func fetchActorAPI(){
        AF.request("https://api.themoviedb.org/3/person/popular?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: ActorModel.self) { response in
           
            self.actorInfo = response.value?.results ?? [ActorResults]()
            self.collectionView.reloadData()
            
            guard response.error == nil else {
                print("Something went wrong on fetchActorAPI in ActorViewController")
                return
            }
        }
    }
}

extension ActorViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if actorInfo.count != 0 {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCollectionViewCell", for: indexPath) as! ActorCollectionViewCell
        cell.actorItem = actorInfo[indexPath.row]
        cell.imageActor.layer.cornerRadius = 20
        cell.imageActor.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.collectionView.bounds.width/2-10, height: 240)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActorDetailViewController") as! ActorDetailViewController
        vc.actorId = actorInfo[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
