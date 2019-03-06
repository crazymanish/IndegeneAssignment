//
//  CodableModel.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 05/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 The `CodableModel` protocol. All model(s) should inherit from this protocol.
 
 */
public protocol CodableModel: Codable {}



/**
 The `CodableModel` Extension.
 Input: A `Dictionary` or `ApiResponse` which Return a JSON Object.
 Output: A `BaseModel` instance.
 
 */
extension CodableModel {
    
    /**
     Init model by using `Dictionary` as Input.
     
     @return BaseModel instance or nil.
     
     */
    public static func initWithDictionary<T: CodableModel>(_ dictionary: [String: Any]) -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return initWithData(data)
        } catch {
            return nil
        }
    }
    
    /**
     Init model by using `ApiResponse` as Input.
     
     @return CodableModel instance or nil.
     
     */
    public static func initWithResponse<T: CodableModel>(_ response: ApiResponse) -> T? {
        guard let data = response.data else {
            print("Response data is nil.")
            return nil
        }
        return initWithData(data)
    }
    
    
    /**
     Init model by using `Data` as Input.
     
     @return CodableModel instance or nil.
     
     */
    public static func initWithData<T: CodableModel>(_ data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Error in JSONDecoder().decode:", error)
            return nil
        }
    }
}
