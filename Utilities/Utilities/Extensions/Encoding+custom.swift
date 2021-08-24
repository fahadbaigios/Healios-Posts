//
//  Encoding+custom.swift
//  Utilities
//
//  Created by Mansoor Ali on 13/03/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//


public extension Encodable {

//	var jsonEncodedData: Data? {
//		return try? JSONEncoder().encode(self)
//	}
    
    func jsonData(keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase) -> Data? {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = keyEncodingStrategy
            return try? encoder.encode(self)
        }

	var json: [String:Any] {
		guard let data =  jsonData() else {
			return [:]
		}
		guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])  else {
			return [:]
		}
		guard let dictionary =  jsonObject as? [String:Any] else {
			return [:]
		}
		return dictionary
	}
}

public extension Dictionary {
	mutating func merge(dict: [Key: Value]){
		for (k, v) in dict {
			updateValue(v, forKey: k)
		}
	}
}
