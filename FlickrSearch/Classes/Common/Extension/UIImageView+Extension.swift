//
//  UIImageView+Extension.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 15/05/21.
//

import UIKit

extension UIImageView {
    func setImage(_ url: URL, placeholder: UIImage) {
        self.image = placeholder
        ImageLoader().requestImage(from: url) { (image) in
            self.image = image
        }
    }
}

