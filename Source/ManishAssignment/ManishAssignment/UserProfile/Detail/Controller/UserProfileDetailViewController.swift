//
//  UserProfileDetailViewController.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 06/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import UIKit

class UserProfileDetailViewController: UIViewController {
    @IBOutlet weak var imageViewProfilePicture: CustomImageView!
    @IBOutlet weak var labelReputationPoints: UILabel!
    @IBOutlet weak var labelGoldBadge: UILabel!
    @IBOutlet weak var labelSilverBadge: UILabel!
    @IBOutlet weak var labelBronzeBadge: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
    // Without userProfile, what this view-controller will do ? 🤣
    var userProfile: UserProfileModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
}


extension UserProfileDetailViewController {
    func configureViews() {
        // Set title
        self.title = self.userProfile.name
        
        // Corner Radius of Image-View
        self.imageViewProfilePicture.layer.cornerRadius = self.imageViewProfilePicture.frame.size.width / 2
        
        //Load Image
        let placeholderImage = UIImage(imageLiteralResourceName: ImageName.noImage)
        self.imageViewProfilePicture.loadImageWithUrl(self.userProfile.image, placeholderImage: placeholderImage)
        
        // Configure Labels
        self.labelReputationPoints.text = "Reputation points: " + String(self.userProfile.reputation)
        self.labelGoldBadge.text = String(self.userProfile.badgeCounts.gold)
        self.labelSilverBadge.text = String(self.userProfile.badgeCounts.silver)
        self.labelBronzeBadge.text = String(self.userProfile.badgeCounts.bronze)
        self.labelLocation.text = self.userProfile.location ?? "-"
    }
}
