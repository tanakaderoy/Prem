//
//  VideoTableViewController.swift
//  PREM
//
//  Created by Student on 4/4/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//
//
import UIKit
import AVKit
import AVFoundation

class VideoTableViewController: UITableViewController, VideoMatchViewModelDelegate {
    
    private let refresherControl = UIRefreshControl()

    func videoMatchUpdated() {
        print("sss\(String(describing: videoMatchViewModel.videoMatch?.count))")
        self.count = (videoMatchViewModel.videoMatch?.count)!
        print("\(self.count)")
        self.tableView.reloadData()
    }
    
    var videoMatchViewModel: VideoMatchViewModel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refresherControl
        } else {
            self.tableView.addSubview(refresherControl)
        }
        
        videoMatchViewModel = VideoMatchViewModel()
        videoMatchViewModel.delegate = self
        videoMatchViewModel.reloadData()
        
        refresherControl.addTarget(self, action: #selector(refreshVideos), for: .valueChanged)
        refresherControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refresherControl.attributedTitle = NSAttributedString(string: "Fetching Videos...")
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshVideos(){
        videoMatchViewModel.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let standings = videoMatchViewModel.videoMatch{
            return standings.count
        }
        
        print("\(self.count)")
        return self.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell;
        if let matchVideo = videoMatchViewModel.matchAtIndex(indexPath.row){
            cell.videoTitleLabel.text = matchVideo.title
        }
        
       
        print("VideoMaych\(String(describing: videoMatchViewModel.videoMatch))")
        cell.webView.allowsInlineMediaPlayback = true
        let video = videoMatchViewModel.matchVideoAtIndex(indexPath.row)
        if let videoUrl = video?.embed{
            
            cell.webView.loadHTMLString(videoUrl, baseURL: nil)
        }
        
        
        return cell
    }
    
    
}
