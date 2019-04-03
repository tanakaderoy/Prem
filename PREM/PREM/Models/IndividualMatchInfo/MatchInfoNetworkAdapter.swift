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
    var matchInfo: MatchInfoRoot?
    var delegate: MatchInfoNetworkAdapterDelegate?
    
    var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var url = "https://api.football-data.org/v2/matches/%d"
    
    private var endpoint: URL? {
        return  URL(string: String(format: url, self.id))
    }
    
    func fetchData() {
        //matchInfo = [MatchInfoRoot]()
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        
        guard let endpoint = self.endpoint else {
            print("url creating failed")
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("ab93dfbf8a73486097b91ac7ba77c9f8", forHTTPHeaderField: "X-Auth-Token")
        let task = session.dataTask(with: request){ (data, response, error)  in
            
            if error != nil || data == nil {
                print("Error fetching data - do somthing")
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Match info Got an error back from the server - do anything )")
                return
            }
            
            if let data = data {
                print( String(data: data, encoding: .utf8)!)
                
                
                let jsonDecoder = JSONDecoder()
                do{
                    self.matchInfo = try jsonDecoder.decode(MatchInfoRoot.self, from: data)
                    print("\(String(describing: self.matchInfo?.match.id))")
                        
//                    self.matchInfo?.append(matchInfoRoot)
                    DispatchQueue.main.async {
                        self.delegate?.matchInfoUpdated()
                    }
                    
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
                
                
            }
        }
        task.resume()
    }
}
