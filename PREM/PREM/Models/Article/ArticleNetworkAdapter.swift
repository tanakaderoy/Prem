//
//  ArticleNetworkAdapter.swift
//  PREM
//
//  Created by Student on 4/16/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation

protocol ArticleNetworkAdapterDelegate {
    func articleUpdated()
}
class ArticleNetworkAdapter: NSObject, URLSessionDelegate {
    var delegate: ArticleNetworkAdapterDelegate?
    var article: [Article]?
    
    private let endpoint =  "https://newsapi.org/v2/everything?q=premier league&apiKey=666cb178e61b4f0883f391ce50daf376&language=en&sortBy=popularity&sources=bbc-sport,talksport"
    func fetchData() {
        article = [Article]()
        
       let urlwithPercentEscapes = endpoint.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        let session = URLSession.init(configuration: .default, delegate: self, delegateQueue: .main)
        let request = URLRequest(url: URL(string: urlwithPercentEscapes!)!)
        //request.setValue("ab93dfbf8a73486097b91ac7ba77c9f8", forHTTPHeaderField: "X-Auth-Token")
       
        let task = session.dataTask(with: request) { (data, response, error)  in
            
            if error != nil || data == nil {
                print("Error fetching data - do somthing")
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Article Network adpterGot an error back from the server - do someting")
                return
            }
            
            
            if let data = data {
                print( String(data: data, encoding: .utf8)!)
                
                
                let jsonDecoder = JSONDecoder()
                do{
                   let root = try jsonDecoder.decode(Response.self, from: data)
                    self.article?.append(contentsOf: root.articles)
                    self.delegate?.articleUpdated()
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }catch let error {
                    print("error with JSON decoding: \(error)")
                }
                
                
            }
        }
        task.resume()
    }
}


