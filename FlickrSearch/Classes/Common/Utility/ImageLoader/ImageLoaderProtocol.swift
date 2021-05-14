//
//  ImageLoaderProtocol.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import UIKit

protocol RequestImages {}

extension RequestImages where Self == ImageLoader {
    func requestImage(from url: URL, completion: @escaping (_ image: UIImage) -> Void){
        if let image = Cache.sharedInstance.object(forKey:  url as NSURL) as? UIImage {
            completion(image)
        }
        self.loadImages(from: url, completion: completion)
    }
}
