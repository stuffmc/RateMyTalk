//
//  ViewController.swift
//  RateMyTalk
//
//  Created by Manuel "StuFF mc" Carrasco Molina on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

import UIKit

class TalkListVC: UICollectionViewController, UICollectionViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func collectionView(collectionView: UICollectionView,
//        viewForSupplementaryElementOfKind kind: String,
//        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//
//        if kind == UICollectionElementKindSectionHeader {
//            let header = collectionView.dequeueReusableCellWithReuseIdentifier("HeaderView", forIndexPath: indexPath) as UICollectionReusableView
//            return header
//        } else {
//            let header = collectionView.dequeueReusableCellWithReuseIdentifier("FooterView", forIndexPath: indexPath) as UICollectionReusableView
//            return header
//        }
//    }
    
    // UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
         return 2
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TalkCell", forIndexPath: indexPath) as UICollectionViewCell
        return cell
    }
}

