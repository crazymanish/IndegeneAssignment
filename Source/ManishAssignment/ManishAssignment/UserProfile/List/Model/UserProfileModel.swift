//
//  UserProfileModel.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 User Profile Model.
 */
struct UserProfileModel: CodableModel {
    let accountId: Int
    let reputation: Int
    let userType: String
    let userId: Int
    let name: String
    let badgeCounts: UserBadgeCountModel
    let image: String?
    let location: String?
    let websiteUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case userType = "user_type"
        case userId = "user_id"
        case name = "display_name"
        case image = "profile_image"
        case websiteUrl = "website_url"
        case badgeCounts = "badge_counts"
        case reputation
        case location
    }
}
