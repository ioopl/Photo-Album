//
//  ExtensionUIImageView.swift
//  Photo-Album
//
//  Created by UHS on 22/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import UIKit

// MARK: - Asynchronous Image Downloading Extension
// Source : http://stackoverflow.com/a/27712427/4326275

extension UIImageView {

     func downloadedFrom(link link:String, contentMode mode: UIViewContentMode) {
        guard
            let url = NSURL(string: link)
            else {return}
        contentMode = mode
        NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.image = image
            }
        }).resume()
    }

}
