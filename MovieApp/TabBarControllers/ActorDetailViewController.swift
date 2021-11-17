//
//  ActorDetailViewController.swift
//  MovieApp
//
//  Created by Ideal Cocaj on 9.11.21.
//

import UIKit
import Alamofire

class ActorDetailViewController: UIViewController {
    
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var nameOfActor: UILabel!
    @IBOutlet weak var placeOfBirth: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var biographyOfActor: UITextView!
    
    var actorId = 0
    var actorInfo: ActorDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchActorDetailAPI()
    }
    
    func setupUI(){
        profileView.layer.cornerRadius = 40
        detailView.layer.cornerRadius = 40
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 5
    }
    
    func fetchActorDetailAPI(){
        
        AF.request("https://api.themoviedb.org/3/person/\(actorId)?api_key=d7a9b95d296376e5fe1942c0a53a5591", method: .get, encoding: JSONEncoding.default).responseDecodable(of: ActorDetail.self) { response in
            self.actorInfo = response.value
            self.setupInfoForActor()
            
            guard response.error == nil else {
                print("Something went wrong on fetchActorDetailAPI in ActorDetailViewController")
                return
            }
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupInfoForActor(){
        
        nameOfActor.text = actorInfo.name
        placeOfBirth.text = actorInfo.place_of_birth
        profession.text = actorInfo.known_for_department
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-yyyy"
        let date = dateformatter.date(from: actorInfo.birthday ?? "")
        let time = dateformatter.string(from: date ?? Date())
        
        dateOfBirth.text = time
        
        if actorInfo.biography == "" {
            return biographyOfActor.text = "This person has no biography to show..."
        } else {
            biographyOfActor.text = actorInfo.biography
        }
        
        if let imageURL = actorInfo.profile_path {
            profileImage.setImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageURL)"))
        }
        
        if actorInfo.gender == 1 {
            return gender.text = "Female"
        } else{
            return gender.text = "Male"
        }
    }
}
