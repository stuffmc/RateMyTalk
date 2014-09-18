//
//  TalkCollectionViewCell.swift
//  RateMyTalk
//
//  Created by Mircea on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

import UIKit

class TalkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var lblSpeaker: UILabel!
    @IBOutlet weak var ratingView: JBRatingView!
    
    weak var talk:Talk?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ratingView.userInteractionEnabled = true
        self.ratingView.ratingChangObserverBlock { (newRating) -> Void in
            if (self.talk != nil) {
                TalkManager().addRating(self.talk!, rating: Int(newRating))
            }
        }
    }
}
