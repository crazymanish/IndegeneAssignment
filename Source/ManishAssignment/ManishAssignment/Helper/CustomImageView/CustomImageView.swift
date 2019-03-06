//
//  CustomImageView.swift
//  ManishAssignment
//
//  Created by Manish Rathi on 05/03/19.
//  Copyright © 2019 Manish. All rights reserved.
//

import UIKit
import Kingfisher

/*
 * CustomImageView: CustomImageView will download the image over the internet.
 *
 * Using Kingfisher library (one the best, now a days) for downloading & cache the image.
 *
 *
 *  Question: Why CustomImageView required?
 *  Answer:
 *  Wrong image can be set to UIImageView when we use UIImageView in table view cell. Because of reusing Tableview cell's UIImageView for downloading different images. For preventing such behaviour we need to store current image url.
 *
 */
class CustomImageView: UIImageView {
    private var currentImageUrl: URL?
    
    func loadImageWithUrl(_ urlString: String?, placeholderImage: UIImage? = nil) {
        //Step1: Try to set the placeHolder image. If exist.
        self.image = placeholderImage
        
        //Step2: Verify that UrlString is valid.
        guard
            let imageUrlString = urlString,
            imageUrlString.count > 0, //Lets make sure UrlString is not empty string.
            let imageUrl = URL(string: imageUrlString)
            else {
                return
            }
        
        // Step3: Update `current ImageUrl` variable.
        self.currentImageUrl = imageUrl
        
        // Step4: Let's cancel the on-going download task if any.
        self.kf.cancelDownloadTask()
        
        //Step5: Let's download the image from server or get it from cache.
        self.kf.setImage(with: imageUrl, placeholder: placeholderImage, options: nil, progressBlock: nil) { [weak self] (result) in
            guard let weakSelf = self else { return }
            if
                let resultValue = try? result.get(),
                let downloadedImageUrl = resultValue.source.url,
                weakSelf.currentImageUrl?.absoluteString != downloadedImageUrl.absoluteString {
                //Ohh....! ImageView has been re-use due to fast-scolling, set back the  placeholder image
                weakSelf.image = placeholderImage
            }
        }
    }
}
