//
//  Reachability.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
import SystemConfiguration

public protocol IReachability : class {
    func isConnectedToNetwork() -> Bool
}

class Reachability {
    enum ConnectionType: String {
        case unknown = "Unknown"
        case none = "None"
        case mobileData = "MobileData"
        case wifi = "WiFi"
    }

    func connectionType() -> ConnectionType {
        let reachability: SCNetworkReachability?
            = SCNetworkReachabilityCreateWithName(nil, "8.8.8.8")
        var flags = SCNetworkReachabilityFlags()

        let success: Bool = SCNetworkReachabilityGetFlags(reachability!, &flags)
        if !success {
            return .unknown
        }
        let isReachable: Bool = flags.contains(.reachable)
        let needsConnection: Bool = flags.contains(.connectionRequired)
        let isNetworkReachable: Bool = (isReachable && !needsConnection)
        if !isNetworkReachable {
            return .none
        } else if flags.contains(.isWWAN) {
            return .mobileData
        } else {
            return .wifi
        }
    }
}

extension Reachability: IReachability {
    func isConnectedToNetwork() -> Bool {
        switch connectionType() {
        case .unknown, .none:
            return false
        default:
            return true
        }
    }
}
