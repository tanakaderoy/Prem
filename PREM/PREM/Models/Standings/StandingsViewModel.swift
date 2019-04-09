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
    private var standings: [Standings]?
    private var standingsNetworkAdapter: StandingsNetworkAdapter!
    
    init(){
        standingsNetworkAdapter = StandingsNetworkAdapter()
        standingsNetworkAdapter.delegate = self
    }
    
    
    var count: Int{
        return standings?.count != nil ? standings!.count: 10
    }
    func reloadData() {
        standingsNetworkAdapter.fetchData()
    }
    
    func standingsAtIndex(_ index: Int) -> Standings? {
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
        self.standings = standingsNetworkAdapter.table
        
        delegate?.standingsUpdated()
    }
}

