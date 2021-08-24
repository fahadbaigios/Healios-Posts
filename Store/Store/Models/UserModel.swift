//
//  UserModel.swift
//  Store
//
//  Created by Fahad Baig on 24/08/2021.
//

import Foundation
import RealmSwift

public class UserAddress: Object, Codable {
    
	@objc dynamic public var street: String = ""
	@objc dynamic public var suite: String = ""
	@objc dynamic public var city: String = ""
	@objc dynamic public var zipcode: String = ""
	@objc dynamic public var geo: Geo?
    
}

public class Geo: Object, Codable {
    
	@objc dynamic public var lat: String = ""
	@objc dynamic public var lng: String = ""

}

public class Company: Object, Codable {
    
	@objc dynamic public var name: String = ""
	@objc dynamic public var catchPhrase: String = ""
	@objc dynamic public var bs: String = ""

}
