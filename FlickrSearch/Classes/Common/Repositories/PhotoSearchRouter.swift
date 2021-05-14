//
//  PhotoSearchRouter.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
enum PhotoSearchRouter {
    case fetchPhoto(searchText: String, pageNo: Int)
    
    internal var path: String {
        switch self {

        case .fetchPhoto(let searchText, let pageNo):
            return String(format: APIEndpoint.photoList, searchText, pageNo)
        }
    }
}
