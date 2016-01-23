//
//  PhotoViewController.swift
//  Photo-Album
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import UIKit
import SwiftyJSON

// Global Variable
public var objectID:Int?

// Constants
private let reuseIdentifier = "Cell"
private let seguePhotoDetails = "ShowPhotoDetails"

class PhotoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var photoData = [Photo]()
    
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        self.collectionView.registerClass(PhotoCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
            withReuseIdentifier: reuseIdentifier)
        
        if let albumID = objectID {
            
            getDataFromAPI("http://jsonplaceholder.typicode.com/photos?albumId=" + "\(albumID)")
        }
    }
    
    
    // MARK: - CollectionView Data Source Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       print(self.photoData.count)
        return self.photoData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        
        if let thumbURL = photoData[indexPath.row].thumbnailUrl {
            
            cell.imgViewPhoto.downloadedFrom(link: thumbURL, contentMode: UIViewContentMode.ScaleAspectFill)
        }
        
        if let mainURL = photoData[indexPath.row].url {
            cell.lblUrl.text = mainURL
        }
        
        if let albumTitle = photoData[indexPath.row].title {
            cell.lblTitle.text = albumTitle
        }
        return cell
    }
    
    
    // MARK: - Navigation
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCollectionViewCell
        if let aid = cell.lblUrl.text {
                    objectIDQueryString = aid
                    self.performSegueWithIdentifier(seguePhotoDetails, sender: self)
        }
    }

    
    // MARK: - API Call to Fetch JSON Data
    func getDataFromAPI(apiURL:String) {
        
        let path = apiURL
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession() // The singleton shared session
        // Data tasks send and receive data using NSData objects.
        let task =
        session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            if let jsonData = data {
                let json = JSON(data: jsonData)
                
                for var i = 0; i < json.count; i++ {
                    if let id = json[i]["id"].int,
                        aid = json[i]["albumId"].int,
                        ttl = json[i]["title"].string,
                        aurl = json[i]["url"].string,
                        turl = json[i]["thumbnailUrl"].string
                    {
                        let photoDetails = Photo(id:id,albumId:aid,title: ttl,url:aurl, thumbnailUrl:turl)
                        self.photoData.append(photoDetails)
                        
                    }
                    
                // Closure to the main queue(thread), to access any UIKit classes.
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.collectionView!.reloadData()
                    })
                }
            }
            //print(self.photoData)
            if (error != nil) {
                self.errorMessage()
            }
        }
        
        task.resume()
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

