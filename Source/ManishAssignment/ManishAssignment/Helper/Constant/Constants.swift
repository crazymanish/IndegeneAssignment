//
//  Constants.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 05/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

// Web-service Api path(s).
struct ApiPath {
    static let getUserProfiles = "users/moderators?site=stackoverflow&filter=!-*jbN0CeyJHb&sort=reputation&order=desc&page=%d"
    //more to go...
}


// UITableView Cell Indetifier(s).
struct UITableViewCellIndentifier {
    static let userProfile = "UserProfileTableViewCell"
    //more to go...
}


// Image Name(s).
struct ImageName {
    static let noImage = "no-image"
    //more to go...
}


// Segue Identifier(s).
struct SegueIndentifier {
    static let userProfileListToDetail = "UserProfileListToDetail"
    //more to go...
}
