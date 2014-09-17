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
    var allTalks: NSArray?

    init() {
    }

    func fetchAllTalks(finishCallback: (NSArray) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: talks, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in
//            println(records)
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

