//
//  RealmController.swift
//  AppsHolderStore
//
//  Created by Fahad Baig on 08/11/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmController{
    
    static let shared = RealmController.init()

    private let baselineUrl = URL(fileURLWithPath: RLMRealmPathForFile("Posts.realm"))
   
    func getHandshakeRealm() -> Realm {
        
		let handshakeConfiguration = Realm.Configuration(fileURL: baselineUrl, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: UInt64(1), migrationBlock: nil, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: [PostMO.self, UserMO.self, CommentMO.self, UserAddress.self, Geo.self, Company.self])
        return try! Realm(configuration: handshakeConfiguration)
    }
    
    private init() {
        print(String(describing:baselineUrl))
    }
    
}

