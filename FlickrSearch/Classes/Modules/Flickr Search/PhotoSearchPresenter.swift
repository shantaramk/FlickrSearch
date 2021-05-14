//
//  PhotoSearchPresenter.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation

final class PhotoSearchPresenter {
    
    //MARK: - Properties
    
    private var wireframe: IPhotoSearchWireframe?
    private var view: IPhotoSearchView?
    private var interactor: IPhotoSearchInteractorInput?
    private var reachability: IReachability?
    
    init(view: IPhotoSearchView,
         interactor: IPhotoSearchInteractorInput,
         wireframe: IPhotoSearchWireframe,
         reachability: IReachability) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.reachability = reachability
    }
}

extension PhotoSearchPresenter {
    func handlePhotoListFetched(_ photos: PhotoBaseModel) {
        guard let view = view else { return }
        view.displayPhotoView(photos)
    }
    
    private func handleError(error: Error?) {
        guard let view = view,
              let reachability = reachability else { return }
        if reachability.isConnectedToNetwork() {
            view.displayError(error)
        } else {
            view.displayNoInternetConnection()
        }
    }
}
//MARK: - Presenter Protocol Implementation

extension PhotoSearchPresenter: IPhotoSearchPresenter {
    func fetchPhotoList(for searchText: String,
                        pageNo: Int) {
        interactor?.fetchPhotoList(for: searchText, pageNo: pageNo)
    }
}

//MARK: - Interactor Output Protocol Implementation

extension PhotoSearchPresenter: IPhotoSearchInteractorOutput {
    func onPhotoListFetched(_ photos: PhotoBaseModel) {
        handlePhotoListFetched(photos)
    }
    
    func onError(_ error: Error?) {
        handleError(error: error)
    }
}
