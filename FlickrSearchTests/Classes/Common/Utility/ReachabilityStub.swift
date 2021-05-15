//
//  ReachabilityStub.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch

class ReachabilityStub: IReachability {

    var isReachable = true
    
    func isConnectedToNetwork() -> Bool {
        return isReachable
    }
}
