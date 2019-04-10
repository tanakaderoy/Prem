//
//  ViewController.swift
//  PREM
//42681052+tanakaderoy@users.noreply.github.com
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit
import SVGKit

class ViewController: UIViewController {
    var matchDayViewModel: MatchDayViewModel!
    var teamViewModel: TeamViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var matchDayLabel: UILabel!
    @IBOutlet weak var matchDayTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createDayPicker()
        createToolbar()
        matchDayViewModel = MatchDayViewModel()
        matchDayViewModel.delegate = self
        teamViewModel = TeamViewModel()
      
        
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func goButtonTouched(_ sender: UIButton) {
        matchDayViewModel.day = Int(selectedDay!)
        matchDayViewModel.reloadMatchDayData()
    }
    let days = [Int](1...32)
    var selectedDay: String?
    
    override func viewWillAppear(_ animated: Bool) {
        
        matchDayViewModel.reloadData()
        
        teamViewModel.reloadData()
        
        
    }
    func createDayPicker(){
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        matchDayTextField.inputView = dayPicker
        
    }
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        matchDayTextField.inputAccessoryView = toolBar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "MatchDay \(days[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDay = "\(days[row])"
        matchDayTextField.text = selectedDay
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
            matchDayLabel.text = "MatchDay: \(matchDayViewModel.matchDayNumber)"
            print("\(match.homeTeam.name) \(match.score.fullTime.homeTeam!) vs \(match.score.fullTime.awayTeam!) \(match.awayTeam.name)")
            
            cell.homeTeamLabel.text = match.homeTeam.name
            cell.awayTeamLabel.text = match.awayTeam.name
            cell.awayTeamScore.text = "\(match.score.fullTime.awayTeam!)"
            cell.homeTeamScore.text = "\(match.score.fullTime.homeTeam!)"
            let teamIndex  = teamViewModel.getIndexOfTeamWithId(match.homeTeam.id )
            if let team = teamViewModel.teamAtIndex(teamIndex ?? 99){
                do {
                    let urlString = "\(team.crestUrl)"
                    
                    let url = URL(string: urlString)
                    let data = try Data(contentsOf: url!)
                    print("team index\(String(describing: teamIndex))")
                    let anSvgImage = SVGKImage(data: data)
                    cell.homeTeamImage.image = anSvgImage?.uiImage
                    
                    print("team index: \(team.id)")
                }
                catch{
                    print(error)
                }
                
            }
            let awayTeamIndex =  teamViewModel.getIndexOfTeamWithId(match.awayTeam.id )
            if let awayTeam = teamViewModel.teamAtIndex(awayTeamIndex ?? 999){
                do {
                    let urlString = "\(awayTeam.crestUrl)"
                    
                    let url = URL(string: urlString)
                    
                    let data = try Data(contentsOf: url!)
                    print("away team index \(String(describing: awayTeamIndex))")
                    if awayTeam.id == 61{
                        cell.awayTeamImage.image = UIImage(named:  "che.png")
                    }else{
                        
                        let anSvgImage = SVGKImage(data: data)
                        cell.awayTeamImage.image = anSvgImage?.uiImage
                    }
                    
                    print("away team id \(awayTeam.id)")
                }
                catch{
                    print(error)
                }
                
            }
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? IndividualMatchInfoViewController {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                if let matchInfo = matchDayViewModel.matchAtIndex(row){
                    vc.id = matchInfo.id
                    
                }
            }
        }
    } 
    
    
    
    
}//end class

extension ViewController: MatchDayViewModelDelegate {
    func matchesUpdated() {
        print("\(self.matchDayViewModel.count)")
        self.tableView.reloadData()
    }
}

