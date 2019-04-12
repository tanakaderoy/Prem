//
//  VideoMatchViewModel.swift
//  PREM
//
//  Created by Student on 4/12/19.
//  Copyright © 2019 Tanaka. All rights reserved
//

import Foundation
protocol VideoMatchViewModelDelegate {
    func videoMatchUpdated()
}
class VideoMatchViewModel {
    var delegate: VideoMatchViewModelDelegate?
    var videoMatch: [VideoMatch]?
    var videoMatchNetworkAdapter: VideoMatchNetworkAdapter!
    
    init(){
        videoMatchNetworkAdapter = VideoMatchNetworkAdapter()
        videoMatchNetworkAdapter.delegate = self
    }
    var count: Int{
        return videoMatch?.count != nil ? videoMatch!.count: 10
    }
    
    func matchAtIndex(_ index: Int) -> Videos? {
        if let videoMatch = videoMatch{
            let video = videoMatch[index]
            return video.videos[0]
        }
        return nil
        
    }
    
    
    func reloadData() {
        videoMatchNetworkAdapter.fetchData()
    }
    
    
}//end class

extension VideoMatchViewModel: VideoMatchNetworkAdapterDelegate{
    
    
    func videoMatchUpdated() {
        self.videoMatch = videoMatchNetworkAdapter.videoMatch
        
        delegate?.videoMatchUpdated()
    }
}

