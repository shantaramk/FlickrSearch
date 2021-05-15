//
//  Alertable.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation
import UIKit

func showAlert(title: String,  message: String) {
    let alertView = AlertView(title: title,
                              message: message,
                              okButtonText: LocalizedStringConstant.okay) { (_, button) in                }
    
    alertView.show(animated: true)
}

