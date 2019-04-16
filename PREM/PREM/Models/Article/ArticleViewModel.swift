//
//  ArticleViewModel.swift
//  PREM
//
//  Created by Student on 4/16/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import Foundation

protocol ArticleViewModelDelegate {
    func articleUpdated()
}
class ArticleViewModel {
    var delegate: ArticleViewModelDelegate?
    var article: [Article]?
    var articleNetworkAdapter: ArticleNetworkAdapter!
    
    init(){
        articleNetworkAdapter = ArticleNetworkAdapter()
        articleNetworkAdapter.delegate = self
    }
 
    
    
    func articleAtIndex(_ index: Int) -> Article? {
        if let article = article{
            return article[index]
        }
        return nil
    }
    
    
    func reloadData() {
        DispatchQueue.main.async {
            self.articleNetworkAdapter.fetchData()
        }
        
    }
    
    
}//end class

extension ArticleViewModel: ArticleNetworkAdapterDelegate{
    
    
    func articleUpdated() {
        self.article = articleNetworkAdapter.article
        
        delegate?.articleUpdated()
    }
}

