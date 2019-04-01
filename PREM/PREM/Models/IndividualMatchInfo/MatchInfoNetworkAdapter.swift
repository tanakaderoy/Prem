//
//  MatchInfoNetworkAdapter.swift
//  PREM
//
//  Created by Student on 4/1/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
protocol MatchInfoNetworkAdapterDelegate {
    func matchInfoUpdated()
}
class MatchInfoNetworkAdapter: NSObject, URLSessionDelegate {
    var delegate: MatchInfoNetworkAdapterDelegate?
    var matchInfo: [MatchInfoRoot]?
    
    private let endpoint =  URL(string: "https://api.football-data.org/v2/matches/233339")!
    
    func fetchData() {
        matchInfo = [MatchInfoRoot]()
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: endpoint)
        request.setValue("ab93dfbf8a73486097b91ac7ba77c9f8", forHTTPHeaderField: "X-Auth-Token")
        let task = session.dataTask(with: request){ (data, response, error)  in
            
            if error != nil || data == nil {
                print("Error fetching data - do somthing")
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Got an error back from the server - do someting")
                return
            }
            
            if let data = data {
                print( String(data: data, encoding: .utf8)!)
                
                
                let jsonDecoder = JSONDecoder()
                do{
                    let matchInfoRoot = try jsonDecoder.decode(MatchInfoRoot.self, from: data)
                        
                    self.matchInfo?.append(matchInfoRoot)
                        self.delegate?.matchInfoUpdated()
                    
                    
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
                
                
            }
        }
        task.resume()
    }
}
