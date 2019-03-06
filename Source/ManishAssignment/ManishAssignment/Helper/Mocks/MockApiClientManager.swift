//
//  MockApiClientManager.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation


/*
 Why This class Needed?
 Answer:
 - stackexchange server only limited hits for free.`http://api.stackexchange.com/2.2/`.
 - So Instead of hitting the actual server, during UI development & testing I am going to use local STUB response from a JSON file.
 */

class MockApiClientManager {
    /**
     Shared Instance of MockApiClientManager.
     */
    static let shared = MockApiClientManager()
}


/**
 Helper method to read Json file.
 */
extension MockApiClientManager {
    class func loadJsonFile(_ fileName: String) -> [String: Any]? {
        if let path = Bundle(for: MockApiClientManager.self).path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary
                }
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
    }
}
