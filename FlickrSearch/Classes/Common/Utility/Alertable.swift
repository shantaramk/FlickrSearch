//
//  Alertable.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
import UIKit

protocol Alertable { }

extension Alertable where Self: UIViewController {
    func showAlert(_ message: String) {
        let alertView = AlertView(title: LocalizedStringConstant.error,
                                  message: LocalizedStringConstant.noInternetConnection,
                                  okButtonText: LocalizedStringConstant.okay) { (_, button) in                }
        
        alertView.show(animated: true)
    }
}
