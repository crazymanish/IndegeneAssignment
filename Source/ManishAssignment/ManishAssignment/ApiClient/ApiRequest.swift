//
//  ApiRequest.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 05/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 The `ApiRequest` protocol. All request(s) should adopt this protocol to use `ApiClientManager`.

 */
public protocol ApiRequest {
    /**
     The path string of URL request.

     */
    var path: String { get set }
    
    
    /**
     The body parameters of the request.

     */
    var body: Dictionary<String, Any>? { get set }
    
    
    /**
     The query parameters of the request.

     */
    var query: Dictionary<String, String>? { get set }
    
    
    /**
     The headers of the request.

     */
    var headers: Dictionary<String, String>? { get set }
}
