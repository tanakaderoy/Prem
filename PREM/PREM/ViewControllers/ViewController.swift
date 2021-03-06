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
    private let refreshControl = UIRefreshControl()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var matchDayLabel: UILabel!
    @IBOutlet weak var matchDayTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        createDayPicker()
        createToolbar()
        matchDayViewModel = MatchDayViewModel()
        matchDayViewModel.delegate = self
        teamViewModel = TeamViewModel()
        matchDayViewModel.reloadData()
        
        teamViewModel.reloadData()
        
        
        
        
        
        
        
        refreshControl.addTarget(self, action: #selector(refreshMatches), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Matches...")
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshMatches(){
        matchDayViewModel.reloadData()
        teamViewModel.reloadData()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func goButtonTouched(_ sender: UIButton) {
        self.dismissKeyboard()
        if(selectedDay.isEmpty){
            if let matchDayTextFieldText = matchDayTextField.text{
                matchDayViewModel.day = Int(matchDayTextFieldText)
            }
        }else{
            matchDayViewModel.day = Int(selectedDay)
            selectedDay = ""
        }
        self.matchesUpdated()
        matchDayViewModel.reloadMatchDayData()
    }
    
    
    let days = [Int](1...38)
    var selectedDay: String = ""
    
    
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
            
            matchDayLabel.text = "MatchDay: \(matchDayViewModel.day ?? matchDayViewModel.matchDayNumber)"
            
            print("\(match.homeTeam.name) \(match.score.fullTime.homeTeam ?? 999) vs \(match.score.fullTime.awayTeam ?? 999) \(match.awayTeam.name)")
            
            
            cell.homeTeamLabel.text = match.homeTeam.name
            
            cell.awayTeamLabel.text = match.awayTeam.name
            if match.score.fullTime.awayTeam == nil {
                cell.awayTeamScore.text = "N/A"
            }else{
                cell.awayTeamScore.text = "\(match.score.fullTime.awayTeam!)"
                
            }
            
            if match.score.fullTime.homeTeam == nil {
                cell.homeTeamScore.text = "N/A"
            }else{
                cell.homeTeamScore.text = "\(match.score.fullTime.homeTeam!)"
                
            }
            
            
            let teamIndex  = teamViewModel.getIndexOfTeamWithId(match.homeTeam.id )
            if let team = teamViewModel.teamAtIndex(teamIndex ?? 99){
                
                
                if let imagePath = Bundle.main.path(forResource: "\(team.tla)", ofType: "svg")
                {
                    
                    let anSvgImage = SVGKImage(contentsOfFile: imagePath)
                    cell.homeTeamImage.image = anSvgImage?.uiImage
                }
                
            }
            let awayTeamIndex =  teamViewModel.getIndexOfTeamWithId(match.awayTeam.id )
            if let awayTeam = teamViewModel.teamAtIndex(awayTeamIndex ?? 999){
                if let imagePath = Bundle.main.path(forResource: "\(awayTeam.tla)", ofType: "svg")
                {
                    
                    let anSvgImage = SVGKImage(contentsOfFile: imagePath)
                    cell.awayTeamImage.image = anSvgImage?.uiImage
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
    
    
    
    
}

extension ViewController: MatchDayViewModelDelegate {
    
    func matchesUpdated() {
        
        print("\(self.matchDayViewModel.count)")
        if(selectedDay.isEmpty){
            
            if let matchdayTextFieldText = matchDayTextField.text{
                
                self.matchDayViewModel.day = Int(matchdayTextFieldText)
                
            }else{
                
                self.matchDayViewModel.day = 38
            }
            
        }else{
            
            self.matchDayViewModel.day = Int(selectedDay)
            self.selectedDay = ""
        }
        self.tableView.reloadData()
    }
}

