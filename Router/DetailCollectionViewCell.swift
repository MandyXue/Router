//
//  DetailCollectionViewCell.swift
//  Router
//
//  Created by MandyXue on 16/5/18.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit
import AVOSCloud

class DetailCollectionViewCell: UICollectionViewCell {
    
    var sharing = SharingModel() {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    
    func updateUI() {
        print("sharing update ui")
        
    }
}
