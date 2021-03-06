//
//  PhotoSearchViewController.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
//

import UIKit
final class PhotoSearchViewController: UIViewController {
    
    //MARK: - Properties
    internal var presenter: IPhotoSearchPresenter?
    private var photos = [Photo]() {
        didSet {
            collectionView.reloadData()
            refreshDataUI()
        }
    }
    private var pageCount = 0
    
    // MARK: UI Elements
    private var searchBarController: UISearchController!
    private var emptyView: EmptyView!

    private lazy var collectionView: UICollectionView = {
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
    
    private var searchText: String {
        guard let text = searchBarController.searchBar.text else {
            return ""
        }
        return text
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
        configureNavigationBar()
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
        searchBarController.isActive = true
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = LocalizedStringConstant.flickrSearch
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
        return UICollectionViewLayout.viewLayout(itemSize: LayoutSize(height: ItemSize.height, width:  ItemSize.width),
                                                 groupSize: LayoutSize(height: GroupSize.height, width: GroupSize.width))
    }
}

//MARK: -  CollectionView DataSource And Delegate

extension PhotoSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pictureCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.photo, for: indexPath) as? PictureCell else { fatalError()}
        pictureCell.pictureView.image = nil
        return pictureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let pictureCell = cell as? PictureCell else { return }
        pictureCell.setData(photos[indexPath.row])
    
        if indexPath.row == (photos.count - 10) {
            fetchNextPage(for: searchText)
        }
    }
}


//MARK: - Private Function: Fetch Request

private extension PhotoSearchViewController {
    func fetchSearchImages(for searchText: String) {
        LoaderView.shared.show(animated: true)
        guard let presenter = presenter else { return }
        presenter.fetchPhotoList(for: searchText, pageNo: pageCount)
    }
    
    func fetchNextPage(for searchText: String) {
        LoaderView.shared.show(animated: true)
        pageCount+=1
        guard let presenter = presenter else { return }
        presenter.fetchPhotoList(for: searchText, pageNo: pageCount)
    }
    
    func refreshDataUI() {
        emptyView.isHidden = !photos.isEmpty
        collectionView.isHidden = photos.isEmpty
    }
    
    func resetView() {
        pageCount = 1
        photos.removeAll()
    }
}


//MARK: - Interactor Input Protocol Implementation

extension PhotoSearchViewController: IPhotoSearchView {
    func displayError(_ error: Error?) {
        LoaderView.shared.dismiss(animated: true)
        showAlert(title:LocalizedStringConstant.error ,
                  message: error.debugDescription)
    }
    
    func displayPhotoView(_ photos: [Photo]) {
        LoaderView.shared.dismiss(animated: true)
        self.photos.append(contentsOf: photos)
    }
    
    func displayNoInternetConnection() {
        LoaderView.shared.dismiss(animated: true)
        showAlert(title:LocalizedStringConstant.error ,
                  message: LocalizedStringConstant.noInternetConnection)
    }
}

//MARK: - UISearchController Delegate

extension PhotoSearchViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        resetView()
        fetchSearchImages(for: text)
        searchBarController.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetView()
    }
}
