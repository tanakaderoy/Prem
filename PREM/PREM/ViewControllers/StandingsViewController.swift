//
//  StandingsViewController.swift
//  PREM
//
//  Created by Student on 4/10/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class StandingsViewController: UIViewController {
    
    var standingsViewModel: StandingsViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        standingsViewModel = StandingsViewModel()
        standingsViewModel.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        standingsViewModel.reloadData()
        
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
        
        return (standingsViewModel.standings?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "standingsCell") as? StandingsTableViewCell else {
            preconditionFailure("Can't find 'schoolCell'")
        }
        let table = standingsViewModel.standingsAtIndex(1)
        print("\(String(describing: table?.team.name))")
        
        
        
        
        
        
        
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
