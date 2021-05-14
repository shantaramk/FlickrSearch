//
//  PhotoModel.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation

struct PhotoBaseModel: Codable {
    let photos: PhotosClass
}

struct PhotosClass: Codable {
    let page, pages, perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Codable, PhotoURL {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

protocol PhotoURL {}

extension PhotoURL where Self == Photo {
     
    func getImagePath() -> URL? {
        let path = "http://farm\(self.farm).static.flickr.com/\(self.server)/\(self.id)_\(self.secret).jpg"
        return URL(string: path)
    }
    
}
