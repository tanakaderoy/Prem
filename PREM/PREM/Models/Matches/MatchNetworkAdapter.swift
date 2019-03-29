//
//  MatchNetworkAdapter.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation
protocol MatchNetworkAdapterDelegate {
    func matchesUpdated()
}
class MatchNetworkAdapter: NSObject, URLSessionDelegate {
    var delegate: MatchNetworkAdapterDelegate?
    var matches: [MatchDay]?
    
    private let endpoint =  URL(string: "https://api.football-data.org/v2/competitions/2021/matches?matchday=30&status=FINISHED")!
    
    func fetchData() {
        matches = [MatchDay]()
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
                    let matchesPage = try jsonDecoder.decode(Root.self, from: data)
                    if matchesPage.matches.count > 0{
                    
                        self.matches?.append(contentsOf: matchesPage.matches)
                        self.delegate?.matchesUpdated()
                    }
                        
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
              
            
            }
        }
        task.resume()
    }
}
