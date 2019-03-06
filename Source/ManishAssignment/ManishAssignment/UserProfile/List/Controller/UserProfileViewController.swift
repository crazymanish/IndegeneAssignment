//
//  UserProfileViewController.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    private var viewModel: UserProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.startAnimating()
        self.tableView.isHidden = true
        
        self.viewModel = UserProfileViewModel(delegate: self)
        self.viewModel.fetchUserProfiles()
    }
}

// TableView Data-Source.
extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCellIndentifier.userProfile, for: indexPath)
        if let userProfileCell = cell as? UserProfileTableViewCell {
            if isLoadingCell(for: indexPath) {
                userProfileCell.configureUserProfileCell(.none)
            } else {
                userProfileCell.configureUserProfileCell(self.viewModel.userProfile(at: indexPath.row))
            }
        }
        return cell
    }
}

// TableView Delegate
extension UserProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userProfile = self.viewModel.userProfile(at: indexPath.row)
        self.performSegue(withIdentifier: SegueIndentifier.userProfileListToDetail, sender: userProfile)
    }
}

// TableView Prefetching Delegate.
extension UserProfileViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.viewModel.fetchUserProfiles()
        }
    }
}

// ViewModel Delegate
extension UserProfileViewController: UserProfileViewModelDelegate {
    func onUserProfilesFetchCompleted(with newIndexPathsToReload: [IndexPath]?, error: Error?) {
        self.indicatorView.stopAnimating()
        if let newIndexPathsToReload = newIndexPathsToReload {
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
            self.tableView.isHidden = false
        } else {
            //TODO: Handle Error: May be some kind of Alert/ Custom Notification.
        }
    }
}

// perform Segue
extension UserProfileViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let detailViewController = segue.destination as? UserProfileDetailViewController,
            let userProfile = sender as? UserProfileModel,
            segue.identifier == SegueIndentifier.userProfileListToDetail {
            detailViewController.userProfile = userProfile
        }
    }
}

// Helper function.
private extension UserProfileViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
