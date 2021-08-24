//
//  Message.swift
//  Meet&GreetStore
//
//  Created by Fahad Baig on 03/02/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import Foundation

open class Message: Decodable {

    public var message: String


    
    public init(message: String) {
        self.message = message
    }
    
    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        message = try container.decode(String.self, forKey: "message")
    }
}
