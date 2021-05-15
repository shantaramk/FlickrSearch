//
//  PhotoSearchInteractor.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
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
        guard let repository = repository, let presenter = presenter  else { return }
        repository.fetchPhotoList(searchText,
                                  pageNo: pageNo,
                                  successHandler: { (data) in
                                    presenter.onPhotoListFetched(data)
                                  }, failureHandler: { (error) in
                                    presenter.onError(error)
                                  })
    }
}
