//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Manuel "StuFF mc" Carrasco Molina on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//


import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var lblSpeaker: UILabel!
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var ratingView: JBRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = CGSizeMake(320, 140)
        
        self.ratingView.mainBackgroundColor = UIColor.greenColor()
        self.ratingView.ratingChangObserverBlock { (rating: CGFloat) -> Void in
            if (rating != 0.0) {
                self.ratingView.userInteractionEnabled = false
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDefaultsDidChange", name: NSUserDefaultsDidChangeNotification, object: nil)
        
    }
    
    func userDefaultsDidChange(notification: NSNotification) {
        let userDefaults = NSUserDefaults(suiteName: "group.biz.pomcast.RateMyTalk")
        
        updateCurrentTalkUI(userDefaults.objectForKey("currentTalk") as Talk)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    func updateCurrentTalkUI(talk: Talk) {
        lblTopic.text = talk.name
    }
}
