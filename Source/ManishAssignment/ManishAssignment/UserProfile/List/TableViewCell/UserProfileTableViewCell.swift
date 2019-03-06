//
//  UserProfileTableViewCell.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewProfilePicture: CustomImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelReputationPoints: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.configureUserProfileCell(.none)
    }
}


extension UserProfileTableViewCell {
    // Configure UserProfile Cell.
    func configureUserProfileCell(_ userProfile: UserProfileModel?) {
        if let userProfile = userProfile {
            // Set Label text
            self.labelName.text = userProfile.name
            self.labelReputationPoints.text = "Reputation points: " + String(userProfile.reputation)
            
            // Corner Radius of Image-View
            self.imageViewProfilePicture.layer.cornerRadius = self.imageViewProfilePicture.frame.size.width / 2
            
            //Load Image
            let placeholderImage = UIImage(imageLiteralResourceName: ImageName.noImage)
            self.imageViewProfilePicture.loadImageWithUrl(userProfile.image, placeholderImage: placeholderImage)
            
            //Stop Animating
            self.indicatorView.stopAnimating()
        } else {
            // Start Animating
            self.indicatorView.startAnimating()
        }
    }
}
