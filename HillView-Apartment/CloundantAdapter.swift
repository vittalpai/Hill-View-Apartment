//
//  CloundantAdapter.swift
//  HealthWealth
//
//  Created by Vittal Pai on 1/18/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import SwiftCloudant


internal class CloudantAdapter {
    internal static var sharedInstance = CloudantAdapter()
    internal var client:CouchDBClient
    internal var dbName:String
    internal var cloudantusername:String?
    internal var cloudantpassword:String?
    internal var cloudantURL:String?
    internal var cloudantName:String?
    
    var images:[UIImage] = [UIImage]()
    
    init() {
        self.dbName = "images"
        self.client = CouchDBClient(url: URL(string:
            "https://2b72064f-9cde-4a71-838d-22babbbf4229-bluemix:a8090115256e106f11dd7e62bd3166fff2b762f4da97ad3b40ebac65b9ca1e83@2b72064f-9cde-4a71-838d-22babbbf4229-bluemix.cloudant.com")!, username: "2b72064f-9cde-4a71-838d-22babbbf4229-bluemix", password: "a8090115256e106f11dd7e62bd3166fff2b762f4da97ad3b40ebac65b9ca1e83")
    }
    
    internal func getDocument(_ completionHandler:@escaping (([String : Any]) -> Void)) {
        let readID = GetDocumentOperation(id: "bba52c46f49a3f988f02d713ce580dca", databaseName: dbName) { (response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while deleting a document. Error: \(error)")
                completionHandler([String : Any]())
            } else {
                completionHandler(response!)
            }
        }
        client.add(operation:readID)
    }
    
    private func getRevisionID(_ documentID: String, completionHandler:@escaping ((String) -> Void)) {
        
        let readID = GetDocumentOperation(id: documentID, databaseName: dbName) { (response, httpInfo, error) in
            if let error = error {
                print("Encountered an error while deleting a document. Error: \(error)")
                completionHandler("")
            } else {
                completionHandler(response?["_rev"] as! String)
            }
        }
        client.add(operation:readID)
    }
    
}
