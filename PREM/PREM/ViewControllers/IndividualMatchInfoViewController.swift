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
    @IBOutlet weak var awayTeamScore: UILabel!
    
    @IBOutlet weak var refereeLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
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
        
        if (match?.referees.count)! > 0 {
            if let referee = match?.referees.first {
                refereeLabel.text = referee.name
            }
        }else{
            refereeLabel.text = "N/A"
        }
        if let homeScore = match?.score.fullTime.homeTeam {
            homeTeamScore.text = "\(homeScore)"
        }else{
            homeTeamScore.text = "N/A"
        }
        if let awayScore = match?.score.fullTime.awayTeam {
            awayTeamScore.text = "\(awayScore)"
        }else{
            awayTeamScore.text = "N/A"
        }
        
        venueLabel.text = match?.venue
        
        let teamIndex  = teamViewModel.getIndexOfTeamWithId(match?.homeTeam.id ?? 999 )
        
        if let team = teamViewModel.teamAtIndex(teamIndex ?? 99){
            print(team.name)
            if let imagePath = Bundle.main.path(forResource: "\(team.tla)", ofType: "svg")
            {
                
                let anSvgImage = SVGKImage(contentsOfFile: imagePath)
                homeTeamImageView.image = anSvgImage?.uiImage
            }
            
        }
        let awayTeamIndex =  teamViewModel.getIndexOfTeamWithId(match?.awayTeam.id ?? 999 )
        if let awayTeam = teamViewModel.teamAtIndex(awayTeamIndex ?? 999){
            if let imagePath = Bundle.main.path(forResource: "\(awayTeam.tla)", ofType: "svg")
            {
                
                let anSvgImage = SVGKImage(contentsOfFile: imagePath)
                awayTeamImageView.image = anSvgImage?.uiImage
            }
        }
        
    }
    
   
}
extension IndividualMatchInfoViewController: MatchInfoViewModelDelegate {
    func matchInfoUpdated() {
        
        print("\(String(describing: matchInfoViewModel.matchInfo))")
       
        DispatchQueue.main.async {
            self.updateUI()
        }
        
        
        
    }
    
    
}
