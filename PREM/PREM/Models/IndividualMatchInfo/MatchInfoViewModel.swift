//
//  MatchInfoViewModel.swift
//  PREM
//
//  Created by Student on 4/1/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//
import Foundation

protocol MatchInfoViewModelDelegate {
    func matchInfoUpdated()
}

class MatchInfoViewModel {
    var delegate: MatchInfoViewModelDelegate?
     var matchInfo: MatchInfoRoot?
    private var matchInfoNetworkAdapter: MatchInfoNetworkAdapter!
    
    init(id: Int){
        matchInfoNetworkAdapter = MatchInfoNetworkAdapter(id: id)
        matchInfoNetworkAdapter.delegate = self
    }
    func reloadData() {
        matchInfoNetworkAdapter.fetchData()
    }

}//end class

extension MatchInfoViewModel: MatchInfoNetworkAdapterDelegate{
    func matchInfoUpdated() {
        self.matchInfo = matchInfoNetworkAdapter.matchInfo
        delegate?.matchInfoUpdated()
    }
}
