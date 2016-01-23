//
//  ViewController.swift
//  Photo-Album
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import UIKit
import SwiftyJSON


private let apiURL = "http://jsonplaceholder.typicode.com/albums"

class AlbumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK : Constants
    let tableName = "TableAlbums"
    let customCell:String = "Cell"
    let segueIdentifier = "goToPhotosViewFromAlbumView"
    
    // MARK: - Variables 
    var albumData = [Album]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "MainViewControllerTableViewCell", bundle: nil), forCellReuseIdentifier: customCell)
    }
    
    
    // MARK: - Fecth and Store Data
    func fetchData() {
        getDataFromAPI(apiURL)
    }
    
    // MARK: - API Call to Fetch JSON Data
    func getDataFromAPI(URL:String) {
        
        let url = NSURL(string: URL)
        let session = NSURLSession.sharedSession() // The singleton shared session
        // Data tasks send and receive data using NSData objects.
        let task =
        session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if let jsonData = data {
                let json = JSON(data: jsonData)
                
                for var i = 0; i < json.count; i++ {
                    if let id = json[i]["id"].int,
                        uid = json[i]["userId"].int,
                        ttl = json[i]["title"].string {
           
                            let album = Album(id: id, userId: uid, title: ttl)
                            self.albumData.append(album)
                    }
                    // Closure to the main queue(thread), to access any UIKit classes.
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
            }
            //print(self.albumData)
            if (error != nil) {
                self.errorMessage()
            }
        }
        
        task.resume()
    }

    // MARK: - Table view data source
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumData.count
     }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MainViewControllerTableViewCell = tableView.dequeueReusableCellWithIdentifier(customCell) as! MainViewControllerTableViewCell
        
        if let cellID = albumData[indexPath.row].id, cellTitle = albumData[indexPath.row].title, cellUserID = albumData[indexPath.row].userId {
        
        
        cell.id.text = "\(cellID)"
        cell.title.text = cellTitle
        cell.userId.text = "\(cellUserID)"
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell:MainViewControllerTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! MainViewControllerTableViewCell
       
        if let objID = Int(cell.id.text!) {
            objectID = objID
            self.performSegueWithIdentifier(segueIdentifier, sender: self)
        }
    }
    
    // MARK: - Error Handling
    func errorMessage() {
        let alertController = UIAlertController(title: "Something went wrong!", message: "Please try later in few moments", preferredStyle: UIAlertControllerStyle.Alert)
        
        let oKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            
        }
        alertController.addAction(oKAction)
        presentViewController(alertController, animated: true) {
        }
    }

}

