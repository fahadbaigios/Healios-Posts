//
//  NetweorkManager.swift
//  iPredictStore
//
//  Created by Fahad Baig on 13/03/2019.
//  Copyright © 2019 Fahad Baig. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public class NetworkManager {
	private var baseUrl: URL!
   // let nearbyURL = URL(string: "https://maps.googleapis.com/maps/api")!
    public static let shared = NetworkManager()
	private var customHeaders: [String:String] = [:]
    
    private let provider = MoyaProvider<ApiEndPoint>()
    
    private init() {}


	/// Configure baseUrl and api-key for api calls
	/// - Parameters:
	///   - baseURL: api url
	///   - apiKey: api-key for api calls
	public func configure(baseURL: URL, apiKey: String) {
		self.baseUrl = baseURL
		customHeaders["api-key"] = apiKey
	}
    
    public func getHeader() -> [String:String] {
        return customHeaders
    }


	/// add headers to custom header
	/// - Parameter headers: new headers
	public func setHeaders(headers: [String:String]) {
		for (key,value) in headers {
			customHeaders[key] = value
		}
	}
    
    /// Create new request and return observable of response model
    ///
    /// - Parameters:
    ///   - method: HTTP method
    ///   - task: task that will be executed
    ///   - path: url path which will be appended at the end of baseurl
    ///   - headers: request header\[
    ///
    /// - Returns: Single(Observable Sequence) of  Reponse Model
    public func newRequest<T>(method: Moya.Method, task: Task, path: String, headers: [String: String]? = nil) -> Single<T> where T: Decodable  {
        let mergedHeaders = add(customHeaders: customHeaders, toRequestHeaders: headers ?? [:])
        let endPoint = ApiEndPoint(baseUrl: baseUrl, customHeaders: mergedHeaders, path: path, method: method, task: task)
        return request(endPoint: endPoint)
    }

//	func newRequestForMultipart<T>(method: Moya.Method, task: Task, path: String, headers: [String: String]? = nil) -> Single<T> where T: Decodable {
//		let mergedHeaders = add(customHeaders: customHeaders, toRequestHeaders: headers ?? [:])
//		let endPoint = ApiEndPoint(baseUrl: baseUrl, customHeaders: mergedHeaders, path: path, method: method, task: task)
//		return request(endPoint: endPoint)
//	}po
    
  /*  func newRequestForMap<T>(method: Moya.Method, task: Task, path: String, headers: [String: String]? = nil) -> PrimitiveSequence<SingleTrait,T> where T: Decodable  {
        let endPoint = ApiEndPoint(baseUrl: nearbyURL, customHeaders: [:], path: path, method: method, task: task)
        return request(endPoint: endPoint)
    }*/

    /// Create new request, filter success status codes and map json to response model
    ///
    /// - Parameter endPoint: contains apiEndPoint
    /// - Returns: Single(Observable Sequence) of  Reponse Model
    private func request<T>(endPoint: ApiEndPoint) -> Single<T> where T: Decodable {
        let request =  provider.rx.request(endPoint)
        
        return request.flatMap { (response) -> Single<T> in
            return Observable.create { [weak self] (observer) -> Disposable in
                do {
                    let data = try response.filterSuccessfulStatusCodes()
                    if T.self != NoResponse.self {
						let decoder = JSONDecoder()
//						decoder.keyDecodingStrategy = .convertFromSnakeCase
						let model = try decoder.decode(T.self, from: data.data)
                        observer.onNext(model)
                    }else {
                        observer.onNext(NoResponse() as! T)
                    }
                }catch {
                    
                    if let moyaError = self?.parseError(error: error) {
                        observer.onError(moyaError)
                    }else {
                        observer.onError(error)
                    }
                }
                
                observer.onCompleted()
                return Disposables.create()
                }.asSingle()
        }
    }
    
    private func parseError(error: Error) -> MoyaError? {
        guard let mError = error as? MoyaError else {
            let nsError = NSError(domain: "error.parsetomoya.failed", code: -1, userInfo: [NSLocalizedDescriptionKey : "Server is unable to handle request"])
            return MoyaError.underlying(nsError, nil)
        }
        
        let statusCode = mError.response?.statusCode ?? 0
        //custom error
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase

		if let errorData = mError.response?.data, let customErrorOptional = try? decoder.decode(ServerError.self, from: errorData),
		   let customError = customErrorOptional.errors.first {
            let nsError = NSError(domain: "", code: mError.response?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey: customError])
            return MoyaError.underlying(nsError, mError.response)
        }
        //internal server error
        else if statusCode == 500 {
            let nsError = NSError(domain: "error.internalserver", code: 500, userInfo: [NSLocalizedDescriptionKey : "Unfortunately, server error occurred"]) //"Server is not responding"])
            return MoyaError.underlying(nsError, nil)
        }else {
            return mError
        }
    }
    
    /// Combine customHeaders and request headers if a key exist in both request header will be selected
    ///
    /// - Parameters:
    ///   - customHeaders: headers in networking manager e.g session token
    ///   - request: request specific header sent in request object
    /// - Returns: merge of custom and request headers
    private func add(customHeaders: [String:String], toRequestHeaders requestHeaders: [String:String]) -> [String:String] {
        var newHeaders = [String:String]()
        
        //Custom Headers
        for (header, value) in customHeaders {
            newHeaders[header] = value
        }
        
        //Request Headers
        for (header, value) in requestHeaders {
            newHeaders[header] = value
        }
        
        return newHeaders
    }
}

/*
public extension NetworkManager {
	func callApi<T>(request: Single<T>) -> Single<T>{
		  return Observable.create { (observer) -> Disposable in
			  return request.subscribe(onSuccess: { (data) in
				  observer.onNext(data)
			  }) { (error) in
				  observer.onError(error)
			  }
		  }.asSingle()
	  }
}
*/
