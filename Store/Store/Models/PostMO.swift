//
//  PostMO.swift
//  Store
//
//  Created by Fahad Baig on 24/08/2021.
//

import Foundation
import RealmSwift
import RxSwift

public class PostMO: Object, Codable {
    @objc dynamic public var userId: Int = -1
    @objc dynamic public var id: Int = -1
    @objc dynamic public var title: String = ""
    @objc dynamic public var body: String = ""
   
    public override class func primaryKey() -> String? {
        return "id"
    }
    
    static func with(id: Int) -> PostMO? {
        let realm = RealmController.shared.getHandshakeRealm()
        return realm.object(ofType: PostMO.self, forPrimaryKey: id)
    }
    
    static func fetchAll() -> [PostMO] {
        let realm = RealmController.shared.getHandshakeRealm()
        return Array(realm.objects(PostMO.self))
    }        
}

extension PostMO{
    static public func loadFromArray(fromArray model:[PostMO], realm:Realm) throws {
        let postsModel = model.map { (output) -> PostMO in
            let postMO = PostMO()
            postMO.userId = output.userId
            postMO.id = output.id
            postMO.title = output.title
            postMO.body = output.body
            
            return postMO
        }

        try realm.write {
            realm.add(postsModel, update: .all)
        }
    }
}
