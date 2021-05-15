//
//  LoaderViewProtocol.swift
//  FlickrSearch
//
//  Created by Dkatalis on 15/05/21.
//

import Foundation
import UIKit
protocol LoaderViewProtocol {
    
    func show(animated: Bool)
    func dismiss(animated: Bool)
    var backgroundView: UIView {get set}
    var containerView: UIView {get set}
}

extension LoaderViewProtocol where Self: UIView {
    
    func show(animated: Bool) {
        self.backgroundView.alpha = 0
          if var topController = UIViewController().window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let subviewsList = topController.view.subviews
            for view in subviewsList where view is AlertView {
                view.removeFromSuperview()
                break
            }
            topController.view.addSubview(self)
        }
 
        if animated {
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundView.alpha = 1.0
                self.containerView.transform = .identity
            }, completion: { (_) in
                self.backgroundView.alpha = 1.0

            })
        }
    }
    
    func dismiss(animated: Bool) {
        if animated {
            self.backgroundView.alpha = 1.0
            self.containerView.transform = .identity
            UIView.animate(withDuration: 0.11, animations: {
                self.backgroundView.alpha = 0.0
                self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { (_) in
                self.backgroundView.alpha = 0.0
                self.removeFromSuperview()
            })
        } else {
            self.backgroundView.alpha = 0.0
            self.removeFromSuperview()
        }
    }
}
