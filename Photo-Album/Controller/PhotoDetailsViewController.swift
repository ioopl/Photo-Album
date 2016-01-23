//
//  PhotoDetailsViewController.swift
//  Photo-Album
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import UIKit

// Global Variable
var objectImageURL = ""
var photoTitle:String? = ""
var photoID:String? = ""
var albumID:String? = ""


class PhotoDetailsViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblAlbumID: UILabel!
    
    // MARK: - Variables
    var imageURL =  objectImageURL
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()


        setupUI()
    }
    
    func setupUI() {
        
        if let aID = albumID, pID = photoID, aTitle = photoTitle {
        
            lblID.text = pID
            lblAlbumID.text = aID
            lblTitle.text = aTitle
        }
        
        scrollViewImage()
    }
    
    func scrollViewImage() {
        
        scrollView.delegate = self
        imageViewPhoto.downloadedFrom(link: imageURL, contentMode: UIViewContentMode.ScaleAspectFit)
        
        imageViewPhoto.userInteractionEnabled = true
        imageViewPhoto.frame = scrollView.bounds
        scrollView.contentSize = CGSizeMake(imageViewPhoto.frame.width, imageViewPhoto.frame.height) // OR  imageViewPhoto.size
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        scrollView.zoomScale = 1.0
    
    }
}
