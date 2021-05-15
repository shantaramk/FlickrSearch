//
//  EmptyView.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
//

import UIKit
class EmptyView: UIView {
    
    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = false
        imageView.image = #imageLiteral(resourceName: "photo-searching-illustrated")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(pictureView)
        
        pictureView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60).isActive = true
        pictureView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pictureView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.79).isActive = true
        pictureView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.24).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
