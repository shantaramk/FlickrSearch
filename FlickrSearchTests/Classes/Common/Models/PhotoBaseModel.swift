//
//  PhotoBaseModel.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import Foundation
@testable import FlickrSearch
extension PhotoBaseModel {
    static func fakeList() -> PhotoBaseModel {
        let photoList = [Photo(id: "PH01",
                               owner: "SBK",
                               secret: "SKRT01",
                               server: "XCR",
                               farm: 2,
                               title: "Cool India",
                               ispublic: 1,
                               isfriend: 3,
                               isfamily: 4),
                         Photo(id: "PH02",
                               owner: "RBK",
                               secret: "SKRT02",
                               server: "XCR",
                               farm: 2,
                               title: "IN India",
                               ispublic: 1,
                               isfriend: 3,
                               isfamily: 4)
        ]
        return PhotoBaseModel(photos: PhotosClass(page: 1, pages: 1, perpage: 1, total: 2, photo: photoList))
    }
}
