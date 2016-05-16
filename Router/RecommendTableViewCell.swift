//
//  RecommendTableViewCell.swift
//  Router
//
//  Created by MandyXue on 16/5/16.
//  Copyright © 2016年 MandyXue. All rights reserved.
//

import UIKit

class RecommendTableViewCell: UITableViewCell{
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceAndDelegate(dataSourceAndDelegate delegate: protocol<UICollectionViewDelegate, UICollectionViewDataSource>) {
        self.collectionView.dataSource = delegate
        self.collectionView.delegate = delegate
        self.collectionView.reloadData()
    }
    
    func updateUI() {
//        collectionView
    }
    

}
