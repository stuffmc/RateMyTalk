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
    
    init() {
        deleteAllTalks()
        // CKAsset for Speaker Photo!
        
    }
    
    func importTalks() {
        let url = NSBundle.mainBundle().URLForResource("Schedule2014", withExtension: "csv")
        let string = NSString(contentsOfURL: url!, encoding: NSASCIIStringEncoding, error: nil)
        let sessions = string.componentsSeparatedByString("\n")
        for session in sessions {
            let attributes = session.componentsSeparatedByString(";")
            //            println(attributes)
            let talkRecord = CKRecord(recordType: talks)
            //            talkRecord.setValue(attributes[0], forKey: "name")
            talkRecord.setValue(attributes[1], forKey: "begin")
            talkRecord.setValue(attributes[2], forKey: "end")
            
            talkRecord.setValue(attributes[3], forKey: "name")
            if attributes.count > 4 {
                talkRecord.setValue(attributes[4], forKey: "speaker")
            }
            
            sleep(3)
            publicDB.saveRecord(talkRecord, completionHandler: { (savedTalk, error) -> Void in
                println(savedTalk)
                println(error)
                //                self.fetchAllTalks()
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

}