//
//  MainViewControllerTableViewCell.swift
//  Photo-Album
//
//  Created by UHS on 21/01/2016.
//  Copyright © 2016 Apkia. All rights reserved.
//

import UIKit

class MainViewControllerTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
