//
//  ArticleTableViewController.swift
//  PREM
//
//  Created by Student on 4/16/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController, ArticleViewModelDelegate {
    func articleUpdated() {
        self.tableView.reloadData()
    }
    
    var articleViewModel: ArticleViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        articleViewModel = ArticleViewModel()
        articleViewModel.delegate = self
       
       articleViewModel.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        articleViewModel.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //videoMatchUpdated()
        
        if let articles = articleViewModel.article{
            return articles.count
        }
        
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell;
        
        if let article = articleViewModel.articleAtIndex(indexPath.row){
            cell.authorLabel.text = article.author
            cell.articleTitleLabel.text = article.title
            cell.articleDescriptionLabel.text = article.description
            if let url = article.urlToImage{
                if let data = try? Data(contentsOf: URL(string: url)!){
                    cell.articleImageView.image = UIImage(data: data)
                }
            }
        }
        
        
       
        
        
        
        
        
        
        
        return cell
    }
}
