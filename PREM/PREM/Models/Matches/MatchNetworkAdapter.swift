//
//  MatchNetworkAdapter.swift
//  PREM
//
//  Created by Student on 3/28/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//
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
    var day: Int?
    
    private let endpoint =  URL(string: "https://api.football-data.org/v2/competitions/2021/matches")

    
    

    func fetchData() {
        
        matches = [MatchDay]()
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: endpoint!)
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
                    let matchesRoot = try jsonDecoder.decode(Root.self, from: data)
                    if matchesRoot.matches.count > 0{
                        
                        self.matches?.append(contentsOf: matchesRoot.matches)
                        self.delegate?.matchesUpdated()
                    }
                    
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
                
                
            }
        }
        task.resume()
    }
    func fetchDataWithMatchDay(day: Int){
        
       
        
        let url = URL(string: "https://api.football-data.org/v2/competitions/2021/matches?")!
        let queryItems = [URLQueryItem(name: "matchday", value: "\(day)"),
                          ]
        let newUrl = url.appending(queryItems)!
        
        matches = [MatchDay]()
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        var request = URLRequest(url: newUrl)
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
                    let matchesRoot = try jsonDecoder.decode(Root.self, from: data)
                    if matchesRoot.matches.count > 0{
                        
                        self.matches?.append(contentsOf: matchesRoot.matches)
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


extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        
        // return the url from new url components
        return urlComponents.url
    }
}
