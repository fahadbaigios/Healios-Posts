//
//  UserMO.swift
//  Store
//
//  Created by Fahad Baig on 24/08/2021.
//

import Foundation
import RealmSwift
import RxSwift

public class UserMO: Object, Codable {
    @objc dynamic public var id: Int = -1
    @objc dynamic public var name: String = ""
    @objc dynamic public var username: String = ""
    @objc dynamic public var email: String = ""
    @objc dynamic public var address: UserAddress?
    @objc dynamic public var phone: String = ""
    @objc dynamic public var website: String = ""
    @objc dynamic public var company: Company?
        
    public override class func primaryKey() -> String? {
        return "id"
    }
    
    static func with(id: Int) -> UserMO? {
        let realm = RealmController.shared.getHandshakeRealm()
        return realm.object(ofType: UserMO.self, forPrimaryKey: id)
    }
    
    static func fetchAll() -> [UserMO] {
        let realm = RealmController.shared.getHandshakeRealm()
        return Array(realm.objects(UserMO.self))
    }        
}

extension UserMO{
    static public func loadFromArray(fromArray model:[UserMO], realm:Realm) throws {
        let usersModel = model.map { (output) -> UserMO in
            let userMO = UserMO()
            userMO.id = output.id
            userMO.name = output.name
            userMO.username = output.username
            userMO.email = output.email
            userMO.address = output.address
            userMO.phone = output.phone
            userMO.website = output.website
            userMO.company = output.company
            return userMO
        }

        try realm.write {
            realm.add(usersModel, update: .all)
        }
    }
}
