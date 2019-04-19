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
    private let refresherControl = UIRefreshControl()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refresherControl
        } else {
            self.tableView.addSubview(refresherControl)
        }
        
        articleViewModel = ArticleViewModel()
        articleViewModel.delegate = self
       
       articleViewModel.reloadData()

        refresherControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        refresherControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refresherControl.attributedTitle = NSAttributedString(string: "Fetching News...")
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshArticles(){
        articleViewModel.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? NewsArticleViewController {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                if let article = articleViewModel.articleAtIndex(row){
                    vc.url = article.url
                }
            }
        }
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let articles = articleViewModel.article{
            return articles.count
        }
        
        
        return 0
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
