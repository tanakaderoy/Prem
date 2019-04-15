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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        standingsViewModel = StandingsViewModel()
        standingsViewModel.delegate = self
         standingsViewModel.reloadData()
        
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
        do{
        let urlString = table?.team.crestUrl
        
            let url = URL(string: urlString ?? "test")
        let data = try Data(contentsOf: url!)
        print("team index\(String(describing: url))")
        let anSvgImage = SVGKImage(data: data)
            cell.clubImageView.image = anSvgImage?.uiImage
    }
    catch{
    print(error)
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
