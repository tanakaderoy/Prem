//
//  NewsArticleViewController.swift
//  PREM
//
//  Created by Student on 4/16/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//

import UIKit

class NewsArticleViewController: UIViewController {
    var url: String?

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView.loadRequest(URLRequest(url: URL(string: url)!))
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
