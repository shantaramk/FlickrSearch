//
//  PhotoSearchRepository.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
protocol IPhotoSearchRepository {
     
}


struct PaymentDetailRepository {
    var service: IWebService?
}


//MARK: - Interactor Input Protocol Implementation

extension PaymentDetailRepository: IPhotoSearchRepository {
    
}
