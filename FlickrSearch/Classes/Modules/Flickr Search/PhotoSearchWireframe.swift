//
//  PhotoSearchWireframe.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
import UIKit

final class PhotoSearchWireframe: IPhotoSearchWireframe {
    
    //MARK: - Properties
    var searchPresenter: IPhotoSearchPresenter?
    
    func setRootViewController(_ window: UIWindow) {
        let viewController = PhotoSearchViewController()
        let presenter = PhotoSearchPresenter(view: viewController,
                                             interactor: PhotoSearchInteractor(repository: PaymentDetailRepository(service: nil)),
                                             wireframe: self,
                                             reachability: Reachability())
        viewController.presenter = presenter
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
