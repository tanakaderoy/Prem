//
//  ViewController.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit
import SVGKit

class ViewController: UIViewController {
    var matchDayViewModel: MatchDayViewModel!
    var teamViewModel: TeamViewModel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        matchDayViewModel = MatchDayViewModel()
        matchDayViewModel.delegate = self
        teamViewModel = TeamViewModel()
        
        
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        matchDayViewModel.reloadData()
        
        teamViewModel.reloadData()
        
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(matchDayViewModel.count)
        return matchDayViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "matchesCell") as? MatchesTableViewCell else {
            preconditionFailure("Can't find 'schoolCell'")
        }
        if let match = matchDayViewModel.matchAtIndex(indexPath.row){
            print("\(match.homeTeam.name) \(match.score.fullTime.homeTeam!) vs \(match.score.fullTime.awayTeam!) \(match.awayTeam.name)")
            cell.homeTeamLabel.text = match.homeTeam.name
            cell.awayTeamLabel.text = match.awayTeam.name
            cell.awayTeamScore.text = "\(match.score.fullTime.awayTeam!)"
            cell.homeTeamScore.text = "\(match.score.fullTime.homeTeam!)"
            if let team = teamViewModel.teamAtIndex(indexPath.row){
            do {
                let urlString = "\(team.crestUrl)"
                let url = URL(string: urlString)
                let data = try Data(contentsOf: url!)
                print(url)
                cell.homeTeamImage.image = SVGKImageView(svgkImage: )//UIImage(data: data)
            }
            catch{
                print(error)
            }
           
        }
        }
        return cell
    }
    
    
}//end class

extension ViewController: MatchDayViewModelDelegate {
    func matchesUpdated() {
            print("\(self.matchDayViewModel.count)")
        self.tableView.reloadData()
    }
}

