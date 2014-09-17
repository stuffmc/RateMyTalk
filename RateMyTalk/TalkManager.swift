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
    var allTalks: NSArray?
    
    init() {
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
            let begin = dateFormatter.dateFromString("\(attributes[0]) \(attributes[1])")
            let end = dateFormatter.dateFromString("\(attributes[0]) \(attributes[2])")
            
            talkRecord.setValue(begin, forKey: "begin")
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

    func fetchAllTalks(finishCallback: (NSArray) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: talks, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            var mutableArray = NSMutableArray()
            for record in records {
                var talk: Talk = Talk(record: record as CKRecord)
                mutableArray.addObject(talk)
            }
            self.allTalks = NSArray(array: mutableArray)
            finishCallback(self.allTalks!)
        }
    }

    func saveTalk(talk: Talk) {
        self.publicDB.saveRecord(talk.record, completionHandler: { (savedTalk, error) -> Void in
            println(error)
        })
    }
}