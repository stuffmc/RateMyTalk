//
//  ViewController.swift
//  RateMyTalk
//
//  Created by Manuel "StuFF mc" Carrasco Molina on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

import UIKit

class TalkListVC: UICollectionViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var talks: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        TalkManager().fetchAllTalks { (allTalks) -> Void in
            self.spinner.stopAnimating()
            self.talks = allTalks
            self.collectionView?.reloadData()
        }
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
        if let array = self.talks {
            return array.count
        }
        return 0;
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TalkCell", forIndexPath: indexPath) as TalkCollectionViewCell
        var talk:Talk = self.talks?.objectAtIndex(indexPath.row) as Talk
        
        cell.lblSpeaker?.text = talk.speaker
        cell.lblTopic?.text = talk.name
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a" // superset of OP's format
        cell.lblTime?.text = dateFormatter.stringFromDate(talk.begin)
        return cell
    }
}

