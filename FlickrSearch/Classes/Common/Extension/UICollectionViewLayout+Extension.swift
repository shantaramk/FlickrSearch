//
//  UICollectionViewLayout+Extension.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 15/05/21.
//

import UIKit

extension UICollectionViewLayout {
    
    static func viewLayout(itemSize: LayoutSize, groupSize: LayoutSize) -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemSize.width),
                                              heightDimension: .fractionalHeight(itemSize.height))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // the add for the each item The the allocate same, box
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupSize.width),
                                               heightDimension: .fractionalWidth(groupSize.height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
