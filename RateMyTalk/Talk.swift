//
//  Talk.swift
//  RateMyTalk
//
//  Created by bogdan on 17/09/14.
//  Copyright (c) 2014 Manuel "StuFF mc" Carrasco Molina. All rights reserved.
//

import Foundation
import CloudKit

class Talk: NSObject {
    
    let recordType = "Talk"
    let nameKey = "name"
    let beginKey = "begin"
    let beginStringKey = "beginString"
    let endKey = "end"
    let endStringKey = "endString"
    let speakerKey = "speaker"
    
    var record: CKRecord
    
    var name: NSString {
        get {
            return self.record.objectForKey(self.nameKey) as NSString
        }
        
        set {
            self.record.setObject(newValue, forKey: self.nameKey)
        }
    }

    var begin: NSDate {
        get {
            return self.record.objectForKey(self.beginKey) as NSDate
        }
        
        set {
            self.record.setObject(newValue, forKey: self.beginKey)
        }
    }
    
    var beginString: NSDate {
        get {
            return self.record.objectForKey(self.beginStringKey) as NSDate
        }
        
        set {
            self.record.setObject(newValue, forKey: self.beginStringKey)
        }
    }
    
    var end: NSDate {
        get {
            return self.record.objectForKey(self.endKey) as NSDate
        }
        
        set {
            self.record.setObject(newValue, forKey: self.endKey)
        }
    }

    var endString: NSDate {
        get {
            return self.record.objectForKey(self.endStringKey) as NSDate
        }
        
        set {
            self.record.setObject(newValue, forKey: self.endStringKey)
        }
    }
    
    var speaker: NSString {
        get {
            return self.record.objectForKey(self.speakerKey) as NSString
        }
        
        set {
            self.record.setObject(newValue, forKey: self.speakerKey)
        }
    }
    
    func addRating (rating: Int, inDatabase database: CKDatabase!) {
        let ratingRecord = CKRecord(recordType: "Ratings")
        ratingRecord.setValue(rating, forKey: "rating")
        let talkReference = CKReference(record: record, action: CKReferenceAction.None)
        ratingRecord.setValue(talkReference, forKey: "talk")
        database.saveRecord(ratingRecord, completionHandler: { (savedTalk, error) -> Void in
            println(savedTalk)
            println(error)
        })
    }
    
    func averageRating(inDatabase database: CKDatabase!, finishCallback: (Float) -> Void) {
        let predicate = NSPredicate(format: "talk = %@", self.record.recordID)
        let query = CKQuery(recordType: "Ratings", predicate: predicate)
        database.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            var sum: Float = 0
            if records.count > 0 {
                for record in records {
                    sum += record.objectForKey("rating") as Float
                }
                sum = sum/Float(records.count)
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                finishCallback(sum)
            })
        }
    }

    // Create from an existing CKRecord
    init(record: CKRecord) {
        self.record = record;
        super.init()
    }

    
}
