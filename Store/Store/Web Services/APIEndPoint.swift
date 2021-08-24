//
//  APIEndPoint.swift
//  Example
//
//  Created by Fahad Baig on 11/01/2020.
//  Copyright © 2018 Techtix All rights reserved.
//

import Foundation
import Moya
//import Result

class ApiEndPoint {

    private var _baseUrl: URL?
    private var _customHeaders: [String:String] = [:]
    private var _path: String = ""
    private var _method: Moya.Method = Moya.Method.post
    private var _task: Task = Task.requestPlain

    init(baseUrl: URL, customHeaders: [String:String], path: String, method: Moya.Method, task: Task) {
        self._baseUrl = baseUrl
        self._customHeaders = customHeaders
        self._path = path
        self._method = method
        self._task = task
    }
}

extension ApiEndPoint: TargetType {
    var baseURL: URL { return _baseUrl!}
    var path: String { return _path }
    var method: Moya.Method { return _method }
    var sampleData: Data { return Data() }
    var task: Task { return _task }

    var headers: [String: String]? {
        return _customHeaders
    }
}

