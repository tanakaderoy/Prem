//
//  IndividualMatchInfoViewController.swift
//  PREM
//
//  Created by Student on 4/1/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit
import SVGKit

class IndividualMatchInfoViewController: UIViewController {
    var matchInfoViewModel: MatchInfoViewModel!
    var teamViewModel: TeamViewModel!
    var id: Int?
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let id = id{
            matchInfoViewModel = MatchInfoViewModel(id: id)
            matchInfoViewModel.delegate = self
            teamViewModel = TeamViewModel()
            
            matchInfoViewModel.reloadData()
            teamViewModel.reloadData()
            
            
            
        }
        
    }
    func updateUI(){
        let match = matchInfoViewModel.matchInfo?.match
        homeTeamLabel.text = match?.homeTeam.name
        awayTeamLabel.text = match?.awayTeam.name
        let teamIndex  = teamViewModel.getIndexOfTeamWithId(match?.homeTeam.id ?? 999 )
        if let team = teamViewModel.teamAtIndex(teamIndex ?? 99){
            let urlString = "\(team.crestUrl)"
            let url = URL(string: urlString)
            let anSvgImage = SVGKImage(contentsOf: url)
            homeTeamImageView.image = anSvgImage?.uiImage
          
            
//            do {
//                let urlString = "\(team.crestUrl)"
//
//                let url = URL(string: urlString)
//                let data = try Data(contentsOf: url!)
//                print("team index\(String(describing: teamIndex))")
//                let anSvgImage = SVGKImage(data: data)
//                homeTeamImageView.image = anSvgImage?.uiImage
//
//                //print("team index: \(team.id)")
//            }
//            catch{
//                print(error)
//            }
            
        }
        let awayTeamIndex =  teamViewModel.getIndexOfTeamWithId(match?.awayTeam.id ?? 999 )
        if let awayTeam = teamViewModel.teamAtIndex(awayTeamIndex ?? 999){
            do {
                let urlString = "\(awayTeam.crestUrl)"
                
                let url = URL(string: urlString)
                
                let data = try Data(contentsOf: url!)
                
                if awayTeam.id == 61{
                    awayTeamImageView.image = UIImage(named:  "che.png")
                }else{
                    
                    let anSvgImage = SVGKImage(data: data)
                    awayTeamImageView.image = anSvgImage?.uiImage
                }
                
                print("away team id \(awayTeamImageView.debugDescription)")
            }
            catch{
                print(error)
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension IndividualMatchInfoViewController: MatchInfoViewModelDelegate {
    func matchInfoUpdated() {
        
        print("\(String(describing: matchInfoViewModel.matchInfo))")
        //print("matches updated: \(self.matchInfoViewModel.count)")
        //print(self.matchInfoViewModel.homeTeamName)
        //let matchIndex = matchInfoViewModel.getIndexOfMatchInfoWithId(id!)
        //print("\(String(describing: matchIndex))")
//        if let singleMatch = matchInfoViewModel.matchInfoAtIndex(matchIndex ?? 999) {
//            homeTeamLabel.text = "\(singleMatch.match.homeTeam.name)"
//        }
        
        updateUI()
        
    }
    
    
}
