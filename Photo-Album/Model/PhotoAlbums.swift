//
//  Album.swift
//  Photo-Album
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import Foundation

struct Album {
    
    let id: Int?
    let userId: Int?
    let title: String?
}

struct Photo {
    
    let id:Int?
    let albumId:Int?
    let title:String?
    let url:String?
    let thumbnailUrl:String?
}


