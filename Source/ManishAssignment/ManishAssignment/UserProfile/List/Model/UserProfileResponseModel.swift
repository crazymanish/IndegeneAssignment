//
//  UserProfileResponseModel.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 User Profile Response Model.
 */
struct UserProfileResponseModel: CodableModel {
    let userProfiles: [UserProfileModel]
    let total: Int
    let hasMore: Bool
    let page: Int
    let quotaMax: Int
    let quotaRemaining: Int
    
    enum CodingKeys: String, CodingKey {
        case userProfiles = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
        case total
        case page
    }
}
