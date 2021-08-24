//
//  CommentModel.swift
//  Store
//
//  Created by Fahad Baig on 24/08/2021.
//

import Foundation

public class Comment: Codable {
    
    public var postId: Int = -1
    public var id: Int = -1
    public var name: String = ""
    public var email: String = ""
    public var body: String = ""
    
    public init() {}
    
}
