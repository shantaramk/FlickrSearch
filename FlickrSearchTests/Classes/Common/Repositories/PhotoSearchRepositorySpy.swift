//
//  PhotoSearchRepositorySpy.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch

class PhotoSearchRepositorySpy: IPhotoSearchRepository {
    
    var searchResults: PhotoBaseModel?
    var errorStub: Error?
    var shouldFail = false

    func fetchPhotoList(_ searchText: String, pageNo: Int, successHandler: @escaping (PhotoBaseModel) -> Void, failureHandler: @escaping (Error?) -> Void) {
        if shouldFail == false, let searchResults = searchResults {
            successHandler(searchResults)
        } else {
            failureHandler(errorStub)
        }
    }
}
