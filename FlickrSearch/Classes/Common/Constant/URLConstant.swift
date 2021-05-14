//
//  APIEndpoint.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
struct Domain {
    static let development = "https://api.flickr.com"
}

struct APIEndpoint {
    static let photoList = "/services/rest/?method=flickr.photos.search&api_key=\(Constants.api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=\(Constants.per_page)&text=%@&page=%ld"
}

class Constants: NSObject {
    static let api_key = "a4f28588b57387edc18282228da39744"
    static let per_page = 60
}
