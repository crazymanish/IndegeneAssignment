//
//  MockApiClientManager+StubUserProfile.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

extension MockApiClientManager: UserProfileApisProtocol {
    /**
     Fetch User Profile Api: Fetch User Profile from STUB Local JSON file.
     
     */
    func fetchUserProfiles(page: Int, completionBlock: @escaping (UserProfileResponseModel?, Error?) -> Void) {
        //1. Get the Fake Response from JSON file
        let fakeResponse = MockApiClientManager.loadJsonFile("StubUserProfilesResponse")
        
        //2. Retun Fake Response.
        if let response = fakeResponse {
            completionBlock(UserProfileResponseModel.initWithDictionary(response), nil)
        } else {
            //3. Return with Fake Error.
            completionBlock(nil, MockError.invalidJsonFile)
        }
    }
    
    
    /**
     TODO: Write here more STUB User Profile related Api(s).
     
     */
}
