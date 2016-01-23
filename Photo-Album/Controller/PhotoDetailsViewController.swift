//
//  PhotoDetailsViewController.swift
//  Photo-Album
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import UIKit

// Global Variable
var objectIDQueryString = ""

class PhotoDetailsViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Variables
    var imageURL =  objectIDQueryString
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        
        imageViewPhoto.downloadedFrom(link: imageURL, contentMode: UIViewContentMode.ScaleAspectFit)

        imageViewPhoto.userInteractionEnabled = true // New
        
        imageViewPhoto.frame = scrollView.bounds
        
        scrollView.contentSize = CGSizeMake(imageViewPhoto.frame.width, imageViewPhoto.frame.height) // OR  imageViewPhoto.size 

        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        scrollView.zoomScale = 1.0
    }
}
