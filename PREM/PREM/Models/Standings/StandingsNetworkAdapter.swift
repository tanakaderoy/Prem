//
//  StandingsNetworkAdapter.swift
//  PREM
//
//  Created by Student on 4/9/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation

protocol StandingsNetworkAdapterDelegate {
    func standingsUpdated()
}

class StandingsNetworkAdapter: NSObject, URLSessionDelegate {
    
    var delegate: StandingsNetworkAdapterDelegate?
    var standing: [Result]?
    
    private let endpoint =  URL(string: "https://api.football-data.org/v2/competitions/2021/standings")!
    
    func fetchData() {
        standing = [Result]()
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: endpoint)
        request.setValue("ab93dfbf8a73486097b91ac7ba77c9f8", forHTTPHeaderField: "X-Auth-Token")
        let task = session.dataTask(with: request){ (data, response, error)  in
            
            if error != nil || data == nil {
                print("Error fetching data - do somthing")
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Standings Network adpterGot an error back from the server - do someting")
                return
            }
            
            
            if let data = data {
                //print( String(data: data, encoding: .utf8)!)
                
                
                let jsonDecoder = JSONDecoder()
                do{
                    let standings = try jsonDecoder.decode(Standing.self, from: data)
                    for stand in standings.standings {
                        self.standing?.append(contentsOf: stand.table)
                        for table in stand.table {
                            print("\(table.team.name)")
                        }
                    }
                    self.delegate?.standingsUpdated()
                    //self.standing?.append(contentsOf: standings.table)
                    
                   
                       
                    
                   
                    
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
                
                
            }
        }
        task.resume()
    }
}

