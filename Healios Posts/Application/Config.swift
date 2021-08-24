//
//  Config.swift
//  Healios Posts
//
//  Created by Fahad Baig on 02/02/2021.
//

import Foundation
class Config {

    #if DEBUG
    static let baseURL = URL(string: "http://jsonplaceholder.typicode.com")!

    #else
    static let baseURL = URL(string: "http://jsonplaceholder.typicode.com")!
    #endif

}
