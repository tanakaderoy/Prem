//
//  VideoTableViewController.swift
//  PREM
//
//  Created by Student on 4/4/19.
//  Copyright © 2019 Tanaka. All rights reserved.
//
//https://github.com/ashish0309/AutoVideoPlayer
import UIKit
import AVKit
import AVFoundation

class VideoTableViewController: UITableViewController, VideoMatchViewModelDelegate {
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
        videoMatchViewModel = VideoMatchViewModel()
        videoMatchViewModel.delegate = self
        videoMatchViewModel.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //videoMatchUpdated()
        
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
            //let requestObj = URLRequest(url: videoUrl )
            cell.webView.loadHTMLString(videoUrl, baseURL: nil)
        }
        
        
        
        
        
        
        
        return cell
    }
    
    
}




















/*
 override func viewDidLoad() {
 super.viewDidLoad()
 
 // Uncomment the following line to preserve selection between presentations
 // self.clearsSelectionOnViewWillAppear = false
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem
 }
 
 // MARK: - Table view data source
 
 override func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 0
 }
 
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return 3
 }
 
 /*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 */
 
 /*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */
 
 /*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */
 
 /*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */
 
 /*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */
 
 /*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
 
 }*/
