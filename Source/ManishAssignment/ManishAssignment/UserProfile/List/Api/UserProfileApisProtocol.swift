//
//  UserProfileApisProtocol.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 UserProfile Apis Protocol
 
 @note: Prorocol oriented approach will always help us in STUB/FAKE response.
 */
protocol UserProfileApisProtocol {
    /**
     User Profile Api(s).
     */
    func fetchUserProfiles(page: Int, completionBlock: @escaping (UserProfileResponseModel?, Error?) -> Void)
    
    
    /**
     TODO: Write here more User Profile related Api(s).
     
     */
}
