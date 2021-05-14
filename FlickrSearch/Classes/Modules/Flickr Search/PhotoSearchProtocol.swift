//
//  PhotoSearchProtocol.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation

//MARK: - Wireframe

protocol IPhotoSearchWireframe {
}

//MARK: - Presenter

protocol IPhotoSearchPresenter {
    func fetchPhotoList(for searchText: String,
                        pageNo: Int)
}

// MARK: - Interactor
protocol IPhotoSearchInteractorInput {
    func fetchPhotoList(for searchText: String,
                        pageNo: Int)
}

protocol IPhotoSearchInteractorOutput {
    func onPhotoListFetched(_ photos: PhotoBaseModel)
    func onError(_ error: Error?)
}

// MARK: - View
protocol IPhotoSearchView {
    func displayPhotoView(_ photos: PhotoBaseModel)
    func displayError(_ error: Error?)
    func displayNoInternetConnection()
}
