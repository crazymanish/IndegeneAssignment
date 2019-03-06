//
//  MockError.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 `MockError` is the error type, encompasses a few different types of errors, each with their own associated reasons.
 */
public enum MockError: Error {
    /**
     `MockError` invalidJsonFile:    Returned when Application is failed to read Json file.
     */
    case invalidJsonFile
    
    /**
     `MockError` jsonDecodedFailed:    Returned when Application not able to build model from JSON.
     */
    case jsonDecoderFailed
}


// MARK: - Error Descriptions
extension MockError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidJsonFile:
            return "InvalidJsonFile Error: Not able to read JSON file."
        case .jsonDecoderFailed:
            return "JsonDecoderFailed Error: Not able to build model from JSON."
        }
    }
}
