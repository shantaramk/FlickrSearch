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
    var photos: PhotoBaseModel? {
        didSet {
            photo =  photos?.photos.photo ?? []
            collectionView.reloadData()
            refreshDataUI()
        }
    }
    var photo = [Photo]()
    private var pageCount = 0
    
    // MARK: UI Elements
    private var searchBarController: UISearchController!
    private var emptyView: EmptyView!

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
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
    }

}

//MARK: -  UI Configure

private extension PhotoSearchViewController {
    func configureView() {
        configureCollectionView()
        configureSearchBar()
        configureEmptyView()
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        collectionView.collectionViewLayout = createGridLayout()
        collectionView.isHidden = true
        registerCells()
    }
    
    func registerCells() {
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: CellIdentifier.photo)
    }
    
    func configureSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.dimsBackgroundDuringPresentation = false
    }
    
    func configureEmptyView() {
        emptyView = EmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isHidden = false
        
        view.addSubview(emptyView)
        emptyView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
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
         pictureCell.setData(photo[indexPath.row],
                            collectionView: collectionView,
                            indexPath: indexPath)
        return pictureCell
    }
}


//MARK: - Private Function: Fetch Request

private extension PhotoSearchViewController {
    func fetchSearchImages(for searchText: String) {
        pageCount+=1   //Count increment here
        presenter?.fetchPhotoList(for: searchText, pageNo: pageCount)
    }
    
    func refreshDataUI() {
        emptyView.isHidden = !photo.isEmpty
        collectionView.isHidden = photo.isEmpty
    }
}


//MARK: - Interactor Input Protocol Implementation

extension PhotoSearchViewController: IPhotoSearchView {
    func displayError(_ error: Error?) {
        print("Error:", error.debugDescription)
    }
    
    func displayPhotoView(_ photos: PhotoBaseModel) {
        self.photos = photos
    }
    
    func displayNoInternetConnection() {
        let alertView = AlertView(title: LocalizedStringConstant.error,
                                  message: LocalizedStringConstant.noInternetConnection,
                                  okButtonText: LocalizedStringConstant.okay) { (_, button) in                }
               
          alertView.show(animated: true)
        
    }
}

//MARK: - UISearchController Delegate

extension PhotoSearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        fetchSearchImages(for: text)
        searchBarController.searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        photos = nil
    }
}
