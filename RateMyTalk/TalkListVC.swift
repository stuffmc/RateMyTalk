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
    var refreshControl: UIRefreshControl?
    var ratings: [Talk: String] = Dictionary<Talk, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "startRefresh", forControlEvents:.ValueChanged)
        self.collectionView?.addSubview(self.refreshControl!)
        self.collectionView?.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startRefresh()
    }
    
    func startRefresh() {
        self.spinner.startAnimating()
        self.ratings.removeAll(keepCapacity: false)
        TalkManager().fetchAllTalks { (allTalks) -> Void in
            for talk in allTalks {
                // Way too complicated!!!
                // Optimization needed
                TalkManager().averageRating(talk, finishCallback: { (Float) -> Void in
                    self.ratings[talk] = String(format: "%.2f", Float)
                    if self.ratings.count == allTalks.count {
                        self.spinner.stopAnimating()
                        self.talks = allTalks
                        self.collectionView?.reloadData()
                        self.refreshControl?.endRefreshing()
                    }
                })
            }
//            self.spinner.stopAnimating()
//            self.talks = allTalks
//            self.collectionView?.reloadData()
//            self.refreshControl?.endRefreshing()
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
        var talk = self.talks?.objectAtIndex(indexPath.row) as Talk
        
        cell.lblSpeaker?.text = talk.speaker
        cell.lblTopic?.text = talk.name
        
        cell.lblTime?.text = talk.beginString

        if let rating = self.ratings[talk] {
            // Switch to swift strings instead of NSString!
            var string = NSString(string: rating)
            cell.ratingView.updateRatingTo(CGFloat(string.floatValue))
        }
        
        return cell
    }
}

