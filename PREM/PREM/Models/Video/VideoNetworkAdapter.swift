//
//  VideoMatchNetworkAdapter.swift
//  PREM
//
//  Created by Student on 4/12/19.
//  Copyright © 2019 Tanaka. All rights reserved
//

import Foundation

protocol VideoMatchNetworkAdapterDelegate {
    func videoMatchUpdated()
}

class VideoMatchNetworkAdapter: NSObject, URLSessionDelegate {
    var delegate: VideoMatchNetworkAdapterDelegate?
    var videoMatch: [VideoMatch]?
    
    private let endpoint =  URL(string: "https://www.scorebat.com/video-api/v1/")!
    
    func fetchData() {
        
        videoMatch = [VideoMatch]()
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        
        let task = session.dataTask(with: endpoint){ (data, response, error)  in
            
            if error != nil || data == nil {
                print("Error fetching data - do somthing")
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("VideoMatch Network adpterGot an error back from the server - do someting")
                return
            }
            
            
            if let data = data {
                print( String(data: data, encoding: .utf8)!)
                
                
                let jsonDecoder = JSONDecoder()
                do{
                    self.videoMatch = try jsonDecoder.decode([VideoMatch].self, from: data)
                    self.delegate?.videoMatchUpdated()
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
                
                
            }
        }
        task.resume()
    }
}

