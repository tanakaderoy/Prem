//
//  MatchDayViewModel.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
protocol MatchDayViewModelDelegate {
    func matchesUpdated()
}
class MatchDayViewModel {
    var delegate: MatchDayViewModelDelegate?
    private var matchday: [MatchDay]?
    private var matchNetworkAdapter: MatchNetworkAdapter!
    var count: Int{
        return matchday?.count != nil ? matchday!.count: 10
    }
    func reloadData() {
        matchNetworkAdapter.fetchData()
    }
    func matchAtIndex(_ index: Int) -> MatchDay? {
        if let match = matchday {
            if match.isValidIndex(index){
                return match[index]
            }
        }
        return nil
    }
}//end class

extension MatchDayViewModel: MatchNetworkAdapterDelegate{
    func matchesUpdated() {
        self.matchday = matchNetworkAdapter.matches
        delegate?.matchesUpdated()
    }
}
