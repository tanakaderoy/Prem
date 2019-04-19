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
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        standingsViewModel = StandingsViewModel()
        
        
        standingsViewModel.delegate = self
        teamViewModel = TeamViewModel()
        standingsViewModel.reloadData()
        teamViewModel.reloadData()
        refreshControl.addTarget(self, action: #selector(refreshStandingData), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Standings...")

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshStandingData(){
        standingsViewModel.reloadData()
        teamViewModel.reloadData()
    }
    
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
       
        print("delegate reached)")
        self.tableView.reloadData()
    }
}
