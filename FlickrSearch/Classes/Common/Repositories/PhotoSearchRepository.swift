//
//  PhotoSearchRepository.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
//

import Foundation
protocol IPhotoSearchRepository {
    func fetchPhotoList(_ searchText: String,
                        pageNo: Int,
                        successHandler: @escaping (PhotoBaseModel) -> Void,
                        failureHandler: @escaping (Error?) -> Void)
}


struct PhotoSearchRepository {
    var service: IWebService?
}

//MARK: - Interactor Input Protocol Implementation

extension PhotoSearchRepository: IPhotoSearchRepository {
    func fetchPhotoList(_ searchText: String,
                        pageNo: Int,
                        successHandler: @escaping (PhotoBaseModel) -> Void,
                        failureHandler: @escaping (Error?) -> Void) {
        
        let request = PhotoSearchRouter.fetchPhoto(searchText: searchText, pageNo: pageNo).path
        service?.performRequest(request,
                                successHandler: { (result) in
                                    successHandler(result)
                                },
                                failureHandler: { (error) in
                                    failureHandler(error)
                                })
    }
}
