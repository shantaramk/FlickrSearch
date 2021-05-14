//
//  ImageLoader.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import UIKit
 
final class Cache: NSCache<AnyObject, AnyObject> {
    static let sharedInstance = Cache()
    private override init() { }
}

final class ImageLoader: RequestImages { }

//MARK: - Fetch image from URL and Images cache

extension ImageLoader {
    func loadImages(from url: URL, completion: @escaping (_ image: UIImage) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        session.downloadTask(with: url) { (imageData, _, error) in
            DispatchQueue.main.async {
                do {
                    guard let imageData = imageData else {
                        return
                    }
                    let data = try Data(contentsOf: imageData)
                    if let image = UIImage(data: data) {
                        Cache.sharedInstance.setObject(image, forKey: url as NSURL)
                        completion(image)
                    } else {
                        debugPrint("Could not decode image")
                    }
                } catch {
                    debugPrint("Could not load URL: \(String(describing: url)): \(error)")
                }
            }
        }.resume()
    }
}
