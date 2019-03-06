//
//  UserBadgeCountModel.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 User Badge Count Model.
 */
struct UserBadgeCountModel: CodableModel {
    let bronze: Int
    let silver: Int
    let gold: Int
}
