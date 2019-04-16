//
//  StandingsViewController.swift
//  PREM
//
//  Created by Student on 4/10/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit
import SVGKit

class StandingsViewController: UIViewController {
    
    var standingsViewModel: StandingsViewModel!
    var teamViewModel: TeamViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        standingsViewModel = StandingsViewModel()
        
        standingsViewModel.delegate = self
        teamViewModel = TeamViewModel()
        standingsViewModel.reloadData()
        teamViewModel.reloadData()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
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
extension StandingsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "standingsCell") as? StandingsTableViewCell else {
            preconditionFailure("Can't find 'schoolCell'")
        }
        let table = standingsViewModel.standingsAtIndex(indexPath.row)
        print("\(String(describing: table?.team.name))")
        cell.labelPostion.text = ("\(table?.position ?? 1)")
        cell.labelPlayed.text = ("\(table?.playedGames ?? 1)")
        cell.labelWon.text = ("\(table?.won ?? 1)")
        cell.labelDrawn.text = ("\(table?.draw ?? 1)")
        cell.labelLost.text = ("\(table?.lost ?? 1)")
        cell.labelPoints.text = ("\(table?.points ?? 1)")
        cell.labelGoalDifference.text = ("\(table?.goalDifference ?? 1)")
        if let teamIndex = teamViewModel.getIndexOfTeamWithId(table?.team.id ?? 0){
             let team = teamViewModel.teamAtIndex(teamIndex)
            if let imagePath = Bundle.main.path(forResource: "\(team!.tla)", ofType: "svg")
            {
                
                let anSvgImage = SVGKImage(contentsOfFile: imagePath)
                cell.clubImageView.image = anSvgImage?.uiImage
            }
        }
        
        
        
        
       
        
        
        
        
        
        return cell
    }
    
    
    
    
    
    
    
    
}
extension StandingsViewController: StandingsViewModelDelegate {
    func standingsUpdated() {
        //let group = self.standingsViewModel.standingsAtIndex(0)?.standings
        print("delegate reached)")
        self.tableView.reloadData()
    }
}
