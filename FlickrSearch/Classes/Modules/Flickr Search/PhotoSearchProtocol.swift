//
//  PhotoSearchProtocol.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
//

import Foundation
import  UIKit

//MARK: - Wireframe

protocol IPhotoSearchWireframe {
    func setRootViewController(_ window: UIWindow)
}

//MARK: - Presenter

protocol IPhotoSearchPresenter {
    func fetchPhotoList(for searchText: String,
                        pageNo: Int)
}

// MARK: - Interactor
protocol IPhotoSearchInteractorInput {
    var presenter: IPhotoSearchInteractorOutput? { get set }
    func fetchPhotoList(for searchText: String,
                        pageNo: Int)
}

protocol IPhotoSearchInteractorOutput {
    func onPhotoListFetched(_ photos: PhotoBaseModel)
    func onError(_ error: Error?)
}

// MARK: - View
protocol IPhotoSearchView {
    func displayPhotoView(_ photos: [Photo])
    func displayError(_ error: Error?)
    func displayNoInternetConnection()
}
