//
//  PictureCell.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import UIKit

final class PictureCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let imageLoader = ImageLoader()

    let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.clipsToBounds = false
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

extension PictureCell {
    func setData(_ photo: Photo?, collectionView: UICollectionView, indexPath: IndexPath) {
        guard let photo = photo, let imageUrl = photo.getImagePath() else { return }
        imageLoader.requestImage(from :imageUrl, completion: { (image) -> Void in
            let indexPath_ = collectionView.indexPath(for: self)
            if indexPath_ == indexPath {
                self.pictureView.image = image
            }
        })
    }
}
