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
//    var count: Int{
//        return matchInfo?.count != nil ? matchInfo!.count: 10
//    }
    func reloadData() {
        matchInfoNetworkAdapter.fetchData()
    }
//
//    func getIndexOfMatchInfoWithId(_ id: Int) -> Int? {
//        if let matchInformation = matchInfo{
//            if matchInformation.contains(where: {($0.match.id == id)}){
//                return matchInformation.firstIndex(where: {($0.match.id == id )})
//            }
//        }
//        return nil
//    }
//    func matchInfoAtIndex(_ index: Int) -> MatchInfoRoot? {
//        if let MatchInfo = matchInfo {
//            if MatchInfo.isValidIndex(index){
//                return MatchInfo[index]
//            }
//        }
//        return nil
//    }
}//end class
extension MatchInfoViewModel: MatchInfoNetworkAdapterDelegate{
    func matchInfoUpdated() {
        self.matchInfo = matchInfoNetworkAdapter.matchInfo
        delegate?.matchInfoUpdated()
    }
}
