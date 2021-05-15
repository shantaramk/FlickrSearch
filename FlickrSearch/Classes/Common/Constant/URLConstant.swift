//
//  APIEndpoint.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
import UIKit

struct Domain {
    static let development = "https://api.flickr.com"
}

struct APIEndpoint {
    static let photoList = "/services/rest/?method=flickr.photos.search&api_key=\(Constants.apiKey)&format=json&nojsoncallback=1&safe_search=1&per_page=\(Constants.perPage)&text=%@&page=%ld"
}

class Constants: NSObject {
    static let apiKey = "a4f28588b57387edc18282228da39744"
    static let perPage = 30
}

struct ItemSize {
    static let height: CGFloat = 1.0
    static let width: CGFloat = 0.333
}

struct GroupSize {
    static let height: CGFloat = 0.4
    static let width: CGFloat = 1.0
}

struct LayoutSize {
    let height: CGFloat
    let width: CGFloat
}
