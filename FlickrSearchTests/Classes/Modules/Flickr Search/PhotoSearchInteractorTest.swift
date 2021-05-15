//
//  PhotoSearchInteractorTest.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import Foundation
import XCTest
@testable import FlickrSearch

class PhotoSearchInteractorTest: XCTestCase {
    //sut stand for System Under Test
    var sut: PhotoSearchInteractor!
    var repository: PhotoSearchRepositorySpy!
    var presenter: PhotoSearchPresenterSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        repository = PhotoSearchRepositorySpy()
        presenter = PhotoSearchPresenterSpy()
        sut = PhotoSearchInteractor(repository: repository)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        repository = nil
        presenter = nil
    }
    
    func testFetchPhotoList() {
        repository.searchResults = PhotoBaseModel.fakeList()
        sut.fetchPhotoList(for: "Cricket", pageNo: 1)
        XCTAssertTrue(presenter.didFetchPhotos)
        
    }
    
    func testOnFailureFetchPhotoList() {
        let errorModel = GeneralErrorModel(errorCode: 100, message: "Unable to load model", errorDomain: "200")
        repository.searchResults = nil
        repository.errorStub = errorModel
        repository.shouldFail = true
        sut.fetchPhotoList(for: "Cricket", pageNo: 1)
        XCTAssertFalse(presenter.didFetchPhotos)
    }
    
    func testFetchPhotoListWithNullPresenter() {
        sut.presenter = nil
        sut.fetchPhotoList(for: "Cricket", pageNo: 2)
        XCTAssertFalse(presenter.didFetchPhotos)
    }
}
