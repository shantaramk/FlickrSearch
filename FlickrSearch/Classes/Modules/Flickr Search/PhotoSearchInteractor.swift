//
//  PhotoSearchInteractor.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
final class PhotoSearchInteractor {
    
    //MARK: - Properties
    var presenter: IPhotoSearchInteractorOutput?
    let repository: IPhotoSearchRepository?
    
    init(repository: IPhotoSearchRepository?) {
        self.repository = repository
    }
}

//MARK: - Interactor Input Protocol Implementation

extension PhotoSearchInteractor: IPhotoSearchInteractorInput {
    func fetchPhotoList(for searchText: String,
                        pageNo: Int) {
        repository?.fetchPhotoList(searchText,
                                   pageNo: pageNo,
                                   successHandler: { (data) in
                                    self.presenter?.onPhotoListFetched(data)
                                   }, failureHandler: { (error) in
                                    self.presenter?.onError(error)
                                   })
    }
}
