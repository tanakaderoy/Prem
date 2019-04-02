//
//  IndividualMatchInfoViewController.swift
//  PREM
//
//  Created by Student on 4/1/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class IndividualMatchInfoViewController: UIViewController {
    var matchInfoViewModel: MatchInfoViewModel!
    var id: Int?
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let id = id{
            matchInfoViewModel = MatchInfoViewModel(id: id)
            matchInfoViewModel.delegate = self
            
            matchInfoViewModel.reloadData()
            
            
            
        }
        
    }
    func updateUI(){
        homeTeamLabel.text = matchInfoViewModel.homeTeamName
        
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
        //print("matches updated: \(self.matchInfoViewModel.count)")
        print(self.matchInfoViewModel.homeTeamName)
        updateUI()
        
    }
    
    
}
