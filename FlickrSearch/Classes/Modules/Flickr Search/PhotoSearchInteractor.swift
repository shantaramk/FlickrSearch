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
    
}
