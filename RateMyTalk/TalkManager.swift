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
    let privateDB = CKContainer.defaultContainer().privateCloudDatabase
    
    init() {
        let talkRecord = CKRecord(recordType: talks)
//        talkRecord["name"] = "Talk Name" // 'CKRecord' does not have a member named 'subscript'
        talkRecord.setValue("Talk name", forKey: "name")
        // CKAsset for Speaker Photo!
        publicDB.saveRecord(talkRecord, completionHandler: { (savedTalk, error) -> Void in
            println(savedTalk)
            println(error)
            self.fetchAllTalks()
        })
        
    }
    
    func fetchAllTalks() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: talks, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
            println(records)
            let reference = CKReference(record: records?.first as CKRecord, action: .None)
        }
    }
    
}