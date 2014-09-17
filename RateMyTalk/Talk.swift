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
    let endKey = "end"
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

    var end: NSDate {
        get {
            return self.record.objectForKey(self.endKey) as NSDate
        }
        
        set {
            self.record.setObject(newValue, forKey: self.endKey)
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

    // Create from an existing CKRecord
    init(record: CKRecord) {
        self.record = record;
        super.init()
    }

    
}
