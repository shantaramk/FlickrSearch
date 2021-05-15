//
//  PhotoSearchRouter.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
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
