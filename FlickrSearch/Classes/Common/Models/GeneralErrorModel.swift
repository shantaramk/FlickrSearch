//
//  GeneralErrorModel.swift
//  FlickrSearch
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit

struct GeneralErrorModel: Error {
    let errorCode: Int
    let message: String
    let errorDomain: String
}
