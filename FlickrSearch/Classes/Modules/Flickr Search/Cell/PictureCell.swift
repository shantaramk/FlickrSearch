//
//  PictureCell.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        //iv.image = #imageLiteral(resourceName: <#T##String#>)
        imageView.clipsToBounds = false //clips image so same size as screen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI Configure

private extension PictureCell {
    func configureUI() {
        configureImageView()
    }
    
    func configureImageView() {
        addSubview(pictureView)
        pictureView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        pictureView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        pictureView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
    }
}
