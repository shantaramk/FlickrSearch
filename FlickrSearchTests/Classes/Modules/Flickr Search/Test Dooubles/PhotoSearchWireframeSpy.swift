//
//  PhotoSearchWireframeSpy.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch

class PhotoSearchWireframeSpy: IPhotoSearchWireframe {
    
    var didSetRootViewController = false

    func setRootViewController(_ window: UIWindow) {
        didSetRootViewController = true
    }
}
