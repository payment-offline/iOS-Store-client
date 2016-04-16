//
//  ItemStoreCollectionViewCell.swift
//  storeApp
//
//  Created by Remi Robert on 16/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class ItemStoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameItemLabel: UILabel!
    @IBOutlet weak var priceItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.clearColor()
    }
    
    func configure(item: Item) {
        self.nameItemLabel.text = item.name
        self.priceItemLabel.text = "\(item.price)"
    }
}
