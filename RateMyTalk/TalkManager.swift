//
//  TalkManager.swift
//  RateMyTalk
//
//  Created by Manuel "StuFF mc" Carrasco Molina on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

import Foundation
import CloudKit

class TalkManager {
    let talks = "Talks"
    let publicDB = CKContainer.defaultContainer().publicCloudDatabase
//    let privateDB = CKContainer.defaultContainer().privateCloudDatabase
    let allQuery = CKQuery(recordType: "Talks", predicate: NSPredicate(value: true))
    var allTalks: Array<Talk>?
    
    init() {
        self.registerLister()
        fetchAllTalks { (talks) -> Void in
            if let talk = talks.first {
                self.addRating(talk, rating: 5)
            }
        }
    }
    
    func importTalks() {
        let url = NSBundle.mainBundle().URLForResource("Schedule2014", withExtension: "csv")
        let string = NSString(contentsOfURL: url!, encoding: NSASCIIStringEncoding, error: nil)
        let sessions = string.componentsSeparatedByString("\n")
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "de_DE")

        for session in sessions {
            let attributes = session.componentsSeparatedByString(";")
            let talkRecord = CKRecord(recordType: talks)
            let beginString = attributes[1] as String
            let begin = dateFormatter.dateFromString("\(attributes[0]) \(beginString)")
            let endString = attributes[2] as String
            let end = dateFormatter.dateFromString("\(attributes[0]) \(endString)")
            
            talkRecord.setValue(beginString, forKey: "beginString")
            talkRecord.setValue(begin, forKey: "begin")
            talkRecord.setValue(endString, forKey: "endString")
            talkRecord.setValue(end, forKey: "end")
            
            talkRecord.setValue(attributes[3], forKey: "name")
            if attributes.count > 4 {
                talkRecord.setValue(attributes[4], forKey: "speaker")
            }
            
            sleep(2)
            publicDB.saveRecord(talkRecord, completionHandler: { (savedTalk, error) -> Void in
                println(savedTalk)
                println(error)
            })
        }
    }
    
    func fetchAllTalks() {
        publicDB.performQuery(allQuery, inZoneWithID: nil) { (records, error) -> Void in
            println(records)
            let reference = CKReference(record: records.first as CKRecord, action: .None)
        }
    }

    func deleteAllTalks() {
        publicDB.performQuery(allQuery, inZoneWithID: nil) { (records, error) -> Void in
            println(records)
            for record in records {
                self.publicDB.deleteRecordWithID((record as CKRecord).recordID, completionHandler: nil)
            }
        }
    }

    func fetchAllTalks(finishCallback: (Array<Talk>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: talks, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            self.allTalks = Array<Talk>()
            for record in records {
                let talk = Talk(record: record as CKRecord)
                self.allTalks?.append(talk)
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                finishCallback(self.allTalks!)
            })
        }
    }

    func saveTalk(talk: Talk) {
        self.publicDB.saveRecord(talk.record, completionHandler: { (savedTalk, error) -> Void in
            println(error)
        })
    }
    
    func addRating (talk: Talk, rating: Int) {
        // TODO: Send back a feedback that it worked. For now, we trust it!x    
        talk.addRating(rating, inDatabase: publicDB)
    }
    
    func registerLister() {
        let predicate = NSPredicate(value: true)
        let subscription = CKSubscription(recordType: "Ratings", predicate: predicate, options:.FiresOnRecordCreation )
        var notificationInfo = CKNotificationInfo()
        notificationInfo.alertLocalizationKey = "LOCAL_NOTIFICATION_KEY"
        notificationInfo.shouldBadge = true
        
        subscription.notificationInfo = notificationInfo;
        
        self.publicDB .saveSubscription(subscription, completionHandler: { (subscription, error) -> Void in
            println(error)
        })
    }
}