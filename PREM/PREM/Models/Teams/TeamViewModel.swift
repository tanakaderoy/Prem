//
//  TeamModelView.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
protocol TeamViewModelDelegate {
    func teamsUpdated()
}
class TeamViewModel {
    var delegate: TeamViewModelDelegate?
    private var teams: [Teams]?
    private var teamNetworkAdapter: TeamNetworkAdapter!
    init(){
        teamNetworkAdapter = TeamNetworkAdapter()
        teamNetworkAdapter.delegate = self
    }
    var count: Int{
        return teams?.count != nil ? teams!.count: 10
    }
    func reloadData() {
        teamNetworkAdapter.fetchData()
    }
    func getIndexOfTeamWithId(_ id: Int) -> Int? {
        if let team = teams{
            if team.contains(where: {($0.id == id)}){
                return team.firstIndex(where: {($0.id == id )})
            }
        }
        return nil
    }
    func teamAtIndex(_ index: Int) -> Teams? {
        if let Team = teams {
            if Team.isValidIndex(index){
                return Team[index]
            }
        }
        return nil
    }
}//end class

extension TeamViewModel: TeamNetworkAdapterDelegate{
    func teamsUpdated() {
        self.teams = teamNetworkAdapter.teams
        delegate?.teamsUpdated()
    }
}
