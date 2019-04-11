//
//  StandingsViewModel.swift
//  PREM
//
//  Created by Student on 4/9/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
protocol StandingsViewModelDelegate {
    func standingsUpdated()
}
class StandingsViewModel {
    var delegate: StandingsViewModelDelegate?
   var standings: [Result]?
    private var standingsNetworkAdapter: StandingsNetworkAdapter!
    
    init(){
        standingsNetworkAdapter = StandingsNetworkAdapter()
        standingsNetworkAdapter.delegate = self
    }
    
    
    func reloadData() {
        standingsNetworkAdapter.fetchData()
    }
    
    func standingsAtIndex(_ index: Int) -> Result? {
        if let standings = standings {
            if standings.isValidIndex(index){
                return standings[index]
            }
        }
        return nil
    }
}//end class

extension StandingsViewModel: StandingsNetworkAdapterDelegate{
    func standingsUpdated() {
        self.standings = standingsNetworkAdapter.standing
        
        delegate?.standingsUpdated()
    }
}

