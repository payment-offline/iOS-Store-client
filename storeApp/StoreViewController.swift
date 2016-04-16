//
//  StoreViewController.swift
//  storeApp
//
//  Created by Remi Robert on 16/04/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayoutFlow: UICollectionViewFlowLayout!
    
    @IBOutlet weak var priceLabelSelected: UILabel!
    @IBOutlet weak var nameLabelSelected: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    let items = Item.generateItem()
    var selectedItem: Item?
    
    func updateSelectedItem() {
        self.priceLabelSelected.text = nil
        self.nameLabelSelected.text = nil
        
        guard let item = self.selectedItem else {
            return
        }
        self.nameLabelSelected.text = item.name
        self.priceLabelSelected.text = "\(item.price)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewLayoutFlow.itemSize = CGSizeMake(CGRectGetHeight(UIScreen.mainScreen().bounds) / 4,
                                                            CGRectGetHeight(UIScreen.mainScreen().bounds) / 2)
        
        let nibCell = UINib(nibName: "ItemStoreCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nibCell, forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        self.updateSelectedItem()
    }
}

extension StoreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedItem = self.items[indexPath.row]
        self.updateSelectedItem()
    }
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ItemStoreCollectionViewCell
        
        cell.configure(self.items[indexPath.row])
        return cell
    }
}
