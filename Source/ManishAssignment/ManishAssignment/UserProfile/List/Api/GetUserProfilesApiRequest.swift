//
//  GetUserProfilesApiRequest.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 Get User Profiles Api Request.
 
 */
struct GetUserProfilesApiRequest: ApiRequest {
    var path: String
    
    var body: Dictionary<String, Any>?
    
    var query: Dictionary<String, String>?
    
    var headers: Dictionary<String, String>?
    
    init() {
        self.path = ApiPath.getUserProfiles
    }
}
