//
//  PhotoSearchWireframe.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
//

import Foundation
import UIKit

final class PhotoSearchWireframe: IPhotoSearchWireframe {
    
    //MARK: - Properties
    var searchPresenter: IPhotoSearchPresenter?
    
    func setRootViewController(_ window: UIWindow) {
        let viewController = PhotoSearchViewController()
        let interactor = PhotoSearchInteractor(repository: PhotoSearchRepository(service: APIManager()))
        let presenter = PhotoSearchPresenter(view: viewController,
                                             interactor: interactor,
                                             wireframe: self,
                                             reachability: Reachability())
        interactor.presenter = presenter
        viewController.presenter = presenter
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
