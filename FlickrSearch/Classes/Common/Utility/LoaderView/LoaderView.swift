//
//  LoaderView.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 15/05/21.
//

import Foundation
import UIKit

class LoaderView: UIView, LoaderViewProtocol {
 
    // MARK: - Properties
    
    weak var delegate: AlertViewDelegate?
    var completionHandler: ((String, ButtonType) -> Void)?
    static let shared = LoaderView()
    
    // MAKR: - Lazy loading view
    internal lazy var backgroundView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        return view
    }()
    
    internal lazy var containerView: UIView = {
        let view = UIView()
        view.frame = frame
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 13.0
        //view.dropShadows(color: .gray, opacity: 1, offSet: CGSize(width: 1.5, height: 0.8), radius: 1, scale: true)
        view.clipsToBounds = true
        return view
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
        setupUIView()
    }

    private func addLoader() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .purple
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.addSubview(activityIndicator)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
    }
    
    private func setupUIView() {
        setupBackgroundView()
        setupContainerView()
        addLoader()
    }
    
    private func setupBackgroundView() {
        addSubview(backgroundView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.numberOfTapsRequired = 1
        //backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func setupContainerView() {
        backgroundView.addSubview(containerView)
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.78).isActive = true
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
