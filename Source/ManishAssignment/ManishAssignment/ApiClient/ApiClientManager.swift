//
//  ApiClientManager.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 05/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Alamofire

/**
 The ApiClientManager class. This class will responsible to execute HTTP REST api networking request(s).

 */
open class ApiClientManager {
    
    /**
     Shared Instance of ApiClientManager.

     */
    public static let shared = ApiClientManager()
    
    /**
     BaseUrl of ApiClientManager.
     
     @note default value is `http://api.stackexchange.com/2.2/`.

     */
    open var baseUrl: String = "http://api.stackexchange.com/2.2/"
    
    /**
     Whether to start requests immediately after being constructed.
     
     @note default value is `true`.

     */
    open var startRequestsImmediately: Bool = true {
        didSet {
            sessionManager.startRequestsImmediately = startRequestsImmediately
        }
    }
    
    //Private variables.
    let sessionManager = Alamofire.SessionManager.default
    
    // Private Init because this class is a singleton class.
    private init() {}
}


extension ApiClientManager {
    /**
     Perform HTTP `GET` request. Request will perform immediately based on `startRequestsImmediately` value.
     
     @param request:        `ApiRequest` instance, which will perform.
     completionBlock:       completionBlock will execute, once the request will finish, return `ApiResponse` as result.
     
     @return Instance of `DataRequest`.

     */
    @discardableResult
    open func get<T: ApiRequest>(_ request: T, completionBlock: @escaping (ApiResponse) -> Void) -> DataRequest {
        return startRequest(request, method: .get, completionBlock: completionBlock)
    }
    
    /**
     Perform HTTP `POST` request. Request will perform immediately based on `startRequestsImmediately` value.
     
     @param request:        `ApiRequest` instance, which will perform.
     completionBlock:       completionBlock will execute, once the request will finish, return `ApiResponse` as result.
     
     @return Instance of `DataRequest`.

     */
    @discardableResult
    open func post<T: ApiRequest>(_ request: T, completionBlock: @escaping (ApiResponse) -> Void) -> DataRequest {
        return startRequest(request, method: .post, completionBlock: completionBlock)
    }
    
    /**
     Perform HTTP `PUT` request. Request will perform immediately based on `startRequestsImmediately` value.
     
     @param request:        `ApiRequest` instance, which will perform.
     completionBlock:       completionBlock will execute, once the request will finish, return `ApiResponse` as result.
     
     @return Instance of `DataRequest`.

     */
    @discardableResult
    open func put<T: ApiRequest>(_ request: T, completionBlock: @escaping (ApiResponse) -> Void) -> DataRequest {
        return startRequest(request, method: .put, completionBlock: completionBlock)
    }
    
    /**
     Perform HTTP `DELETE` request. Request will perform immediately based on `startRequestsImmediately` value.
     
     @param request:        `ApiRequest` instance, which will perform.
     completionBlock:       completionBlock will execute, once the request will finish, return `ApiResponse` as result.
     
     @return Instance of `DataRequest`.

     */
    @discardableResult
    open func delete<T: ApiRequest>(_ request: T, completionBlock: @escaping (ApiResponse) -> Void) -> DataRequest {
        return startRequest(request, method: .delete, completionBlock: completionBlock)
    }
}


extension ApiClientManager {
    /// Helper private method: specific type of `Request` that manages an underlying `URLSessionDataTask`.
    @discardableResult
    fileprivate func startRequest<T: ApiRequest>(_ request: T, method: HTTPMethod, completionBlock: @escaping (ApiResponse) -> Void) ->DataRequest {
        let request = sessionManager.request(baseUrl + request.path,
                                             method: method,
                                             parameters: request.body,
                                             encoding: JSONEncoding.default,
                                             headers: request.headers).validate().response { (dataResponse) in
                                                let response = ApiResponse(request: dataResponse.request,
                                                                                response: dataResponse.response,
                                                                                data: dataResponse.data,
                                                                                error: dataResponse.error)
                                                completionBlock(response)
        }
        return request
    }
}
