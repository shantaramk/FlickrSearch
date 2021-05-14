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

//MARK: - Presenter Protocol Implementation

extension PhotoSearchPresenter: IPhotoSearchPresenter {
    
}

//MARK: - Interactor Output Protocol Implementation

extension PhotoSearchPresenter: IPhotoSearchInteractorOutput {
    
}
