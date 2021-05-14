//
//  PhotoSearchViewController.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import UIKit
final class PhotoSearchViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: IPhotoSearchPresenter?
    var photos: PhotoBaseModel?
    private var pageCount = 0

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    var searchText: String {
        return "Girls"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        collectionView.reloadData()
        fetchSearchImages()
    }

}

//MARK: -  UI Configure

private extension PhotoSearchViewController {
    func configureView() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        collectionView.collectionViewLayout = createGridLayout()
        registerCells()
    }
    
    func registerCells() {
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: CellIdentifier.photo)
    }
    
    //MARK:- GridView Layout
    
    private func createGridLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333),
                                              heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // the add for the each item The the allocate same, box
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

//MARK: -  CollectionView DataSource And Delegate

extension PhotoSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photo = photos?.photos.photo else { return 0 }
        return photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.photo, for: indexPath) as? PictureCell else { fatalError()}
        let photo =  photos?.photos.photo ?? []
        pictureCell.setData(photo[indexPath.row],
                            collectionView: collectionView,
                            indexPath: indexPath)
        return pictureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        displayNoInternetConnection()
    }
}


//MARK: - Private Function: Fetch Request

private extension PhotoSearchViewController {
    func fetchSearchImages() {
        pageCount+=1   //Count increment here
        presenter?.fetchPhotoList(for: searchText, pageNo: pageCount)
    }
}


//MARK: - Interactor Input Protocol Implementation

extension PhotoSearchViewController: IPhotoSearchView {
    func displayError(_ error: Error?) {
        print("Error:", error.debugDescription)
    }
    
    func displayPhotoView(_ photos: PhotoBaseModel) {
        self.photos = photos
        collectionView.reloadData()
    }
    
    func displayNoInternetConnection() {
        let alertView = AlertView(title: LocalizedStringConstant.error,
                                  message: LocalizedStringConstant.noInternetConnection,
                                  okButtonText: LocalizedStringConstant.okay) { (_, button) in                }
               
          alertView.show(animated: true)
        
    }
}

