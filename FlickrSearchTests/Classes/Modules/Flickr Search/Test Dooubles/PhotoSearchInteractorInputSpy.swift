//
//  PhotoSearchInteractorInputSpy.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch

class PhotoSearchInteractorInputSpy: IPhotoSearchInteractorInput {
    
    var presenter: IPhotoSearchInteractorOutput?
    var searchResults: PhotoBaseModel?
    var error: Error?

    func fetchPhotoList(for searchText: String, pageNo: Int) {
        if let searchResults = searchResults {
            presenter?.onPhotoListFetched(searchResults)
        } else {
            presenter?.onError(error)
        }
    }
}
