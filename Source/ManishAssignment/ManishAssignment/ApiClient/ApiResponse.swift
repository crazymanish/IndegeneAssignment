//
//  ApiResponse.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 05/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 The `ApiResponse` protocol. `ApiClientManager` will always return the `ApiResponse` object in `CompletionBlock`.

 */
public struct ApiResponse {
    /**
     The URL request which was sent to the server.

     */
    public let request: URLRequest?
    
    
    /**
     The server's response to the URL request.

     */
    public let response: HTTPURLResponse?
    
    
    /**
     The data returned by the server.

     */
    public let data: Data?
    
    
    /**
     The error encountered while executing the request.

     */
    public let error: Error?
}



public extension ApiResponse {
    /**
     Check anytime, Response is valid or not.

     */
    public var isValid: Bool {
        return response?.statusCode == 200 && data != nil && error == nil
    }
    
    
    /**
     JSON Object of Response's data.

     */
    public var json: Any? {
        if let data = data {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print("Error in JSONSerialization.jsonObject \(error)")
                return nil
            }
        }
        return nil
    }
}
