//
//  CommentMO.swift
//  Store
//
//  Created by Fahad Baig on 24/08/2021.
//

import Foundation
import RealmSwift
import RxSwift

public class CommentMO: Object, Codable {
    @objc dynamic public var postId: Int = -1
    @objc dynamic public var id: Int = -1
    @objc dynamic public var name: String = ""
    @objc dynamic public var email: String = ""
    @objc dynamic public var body: String = ""
    
    public override class func primaryKey() -> String? {
        return "id"
    }
    
    static func with(id: Int) -> CommentMO? {
        let realm = RealmController.shared.getHandshakeRealm()
        return realm.object(ofType: CommentMO.self, forPrimaryKey: id)
    }
    
    static func fetchAll() -> [CommentMO] {
        let realm = RealmController.shared.getHandshakeRealm()
        return Array(realm.objects(CommentMO.self))
    }
        
}

extension CommentMO{
    static public func loadFromArray(fromArray model:[CommentMO], realm:Realm) throws {
        let commentsModel = model.map { (output) -> CommentMO in
            let commentMO = CommentMO()
            commentMO.postId = output.postId
            commentMO.id = output.id
            commentMO.name = output.name
            commentMO.email = output.email
            commentMO.body = output.body
            
            return commentMO
        }

        try realm.write {
            realm.add(commentsModel, update: .all)
        }
    }
}

