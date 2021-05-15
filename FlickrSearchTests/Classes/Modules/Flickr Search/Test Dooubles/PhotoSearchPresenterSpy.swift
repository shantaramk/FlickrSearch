//
//  PhotoSearchPresenterSpy.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch

class PhotoSearchPresenterSpy: IPhotoSearchPresenter, IPhotoSearchInteractorOutput {
    
    var searchResults: PhotoBaseModel?
    var error: Error?
    var didFetchPhotos = false

    func fetchPhotoList(for searchText: String, pageNo: Int) {
        didFetchPhotos = true
    }
    
    func onPhotoListFetched(_ photos: PhotoBaseModel) {
        searchResults = photos
        didFetchPhotos = true
    }
    
    func onError(_ error: Error?) {
        self.error =  error
    }
}
