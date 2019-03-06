//
//  UserProfileViewModel.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import Foundation

/**
 The UserProfileViewModelDelegate Protocol.
 This Protocol is responsible to communicate back with ViewController....will send event(s).
 
 @note: RxSwift might be killer here, not using because Assignment rules say, use Only Alamofire library.
 */
protocol UserProfileViewModelDelegate: class {
    func onUserProfilesFetchCompleted(with newIndexPathsToReload: [IndexPath]?, error: Error?)
}


/**
 The UserProfileViewModel Class.
 This class is responsible to perform business logic for UserProfile list screen.
 */
final class UserProfileViewModel {
    fileprivate weak var delegate: UserProfileViewModelDelegate?
    fileprivate var userProfiles: [UserProfileModel] = []
    fileprivate var currentPage = 1
    fileprivate var total = 0
    fileprivate var isFetchInProgress = false
    /**
     This is UserProfile Api Client, which is reponsible to get data either from server or FAKE.
     
     How to Use:
     For Actual Server Response: let userProfileApiClient: UserProfileApisProtocol = ApiClientManager.shared
     For FAKE/Stub Response: let userProfileApiClient: UserProfileApisProtocol = MockApiClientManager.shared
     
     @note:
     1. ApiClientManager.shared will hit Actual server.
     2. MockApiClientManager.shared will return STUB/FAKE response from local JSON File.
     
     Why This Needed?
     Answer:
     - stackexchange server only limited hits for free.`http://api.stackexchange.com/2.2/`.
     - So Instead of hitting the actual server, during UI development & testing I am going to use local STUB response from a JSON file.
     - Later we can use this approach for writing the Unit test-cases.
     */
    fileprivate let userProfileApiClient: UserProfileApisProtocol = MockApiClientManager.shared
    
    // Custom init with delegate as param.
    init(delegate: UserProfileViewModelDelegate) {
        self.delegate = delegate
    }
}

// Helper Read-Only Api(s)
extension UserProfileViewModel {
    var totalCount: Int {
        return self.total
    }
    
    var currentCount: Int {
        return self.userProfiles.count
    }
    
    func userProfile(at index: Int) -> UserProfileModel {
        return self.userProfiles[index]
    }
}

// Fetch User Profiles from server.
extension UserProfileViewModel {
    func fetchUserProfiles() {
        // 1. Make sure Fetch is not in progress.
        guard !self.isFetchInProgress else {
            return
        }
        
        // 2. Mark it true.
        self.isFetchInProgress = true
        
        // 3. Fetch User Profiles using Api Client.
        self.userProfileApiClient.fetchUserProfiles(page: self.currentPage) { [weak self] (responseModel, error) in
            // Make sure, using weakSelf inside Blocks
            guard let weakSelf = self else { return }
            
            // 4. Got Response, Mark it false.
            weakSelf.isFetchInProgress = false
            
            // 5. Check if Reponse is a valid response.
            if let response = responseModel {
                // 6. Increase this for next pagination api call.
                weakSelf.currentPage += 1
                
                //7. Update viewModel.
                weakSelf.total = response.total
                weakSelf.userProfiles.append(contentsOf: response.userProfiles)
                
                // 8. Check if page has been loaded.
                if response.page > 0 {
                    let indexPathsToReload = weakSelf.calculateIndexPathsToReload(from: response.userProfiles)
                    weakSelf.delegate?.onUserProfilesFetchCompleted(with: indexPathsToReload, error: nil)
                } else {
                    weakSelf.delegate?.onUserProfilesFetchCompleted(with: .none, error: nil)
                }
            } else {
                // 9. Api failed, Send failure event using delegate.
                weakSelf.delegate?.onUserProfilesFetchCompleted(with: nil, error: error)
            }
        }
    }
    
    //Helper method to calculate new indexpath.
    private func calculateIndexPathsToReload(from newUserProfiles: [UserProfileModel]) -> [IndexPath] {
        let startIndex = userProfiles.count - newUserProfiles.count
        let endIndex = startIndex + newUserProfiles.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
