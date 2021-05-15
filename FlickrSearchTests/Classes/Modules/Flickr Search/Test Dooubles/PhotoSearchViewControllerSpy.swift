//
//  PhotoSearchViewControllerSpy.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch

class PhotoSearchViewControllerSpy: IPhotoSearchView {
    
    var photos = [Photo]()
    var error: Error?
    var didShowErrorNoInternetConnection = false
    var didShowPhotoList = false
    var didShowError = false

    func displayPhotoView(_ photos: [Photo]) {
        self.photos = photos
        didShowPhotoList = true
    }
    
    func displayError(_ error: Error?) {
        self.error = error
        didShowError = true
    }
    
    func displayNoInternetConnection() {
        didShowErrorNoInternetConnection = true
    }
    

}
