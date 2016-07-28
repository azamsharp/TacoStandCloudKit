//
//  ViewController.swift
//  TacoStandCloudKit
//
//  Created by Mohammad Azam on 7/28/16.
//  Copyright © 2016 Mohammad Azam. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    var container :CKContainer!
    var publicDB :CKDatabase!
    var privateDB :CKDatabase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.container = CKContainer.defaultContainer()
        self.publicDB = self.container.publicCloudDatabase
        self.privateDB = self.container.privateCloudDatabase
        
    }
    
    @IBAction func deleteTaco() {
        
        let query = CKQuery(recordType: "Establishment", predicate: NSPredicate(format: "Name = %@", "My Favorite Taco"))
        
        self.publicDB.performQuery(query, inZoneWithID: nil) { (records :[CKRecord]?, error :NSError?) in
            
            if let records = records {
                
                if let record = records.first {
                    
                    self.publicDB.deleteRecordWithID(record.recordID, completionHandler: { (recordId :CKRecordID?, error :NSError?) in
                        
                    })
                
                }
                
            }
            
        }
        
    }
    
    @IBAction func getAllTacosButtonPressed() {
        
        let query = CKQuery(recordType: "Establishment", predicate: NSPredicate(value: true))
        
        self.publicDB.performQuery(query, inZoneWithID: nil) { (records :[CKRecord]?, erro :NSError?) in
            
            for record in records! {
                print(record["Name"])
                print(record["Details"])
            }
            
        }
        
    }
    
    @IBAction func createTacoRecordButtonPressed() {
        
        let tacoRecord = CKRecord(recordType: "Establishment")
        tacoRecord["Name"] = "My Favorite Taco"
        tacoRecord["Details"] = "Fav Taco Details"
        
        self.publicDB.saveRecord(tacoRecord) { (record :CKRecord?, error :NSError?) in
            
            print(record?.recordID)
            
        }
        
        
        //self.publicDB.save
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

