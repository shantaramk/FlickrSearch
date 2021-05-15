//
//  PhotoSearchPresenterTest.swift
//  FlickrSearchTests
//
//  Created by Dkatalis on 15/05/21.
//

import UIKit
@testable import FlickrSearch
import XCTest

class PhotoSearchPresenterTest: XCTestCase {
    
    /// sut stand for system under test
    var sut: PhotoSearchPresenter!
    var wireframe: PhotoSearchWireframeSpy!
    var view: PhotoSearchViewControllerSpy!
    var interactor: PhotoSearchInteractorInputSpy!
    var reachability: ReachabilityStub!

    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    
        wireframe = PhotoSearchWireframeSpy()
        view = PhotoSearchViewControllerSpy()
        interactor = PhotoSearchInteractorInputSpy()
        reachability = ReachabilityStub()
        
        sut = PhotoSearchPresenter(view: view,
                                   interactor: interactor,
                                   wireframe: wireframe,
                                   reachability: reachability)
        interactor?.presenter = sut
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        wireframe = nil
        view = nil
        interactor = nil
        reachability = nil
    }
    
    // MARK: Tests

    func testOnErrorNoInternet() {
        reachability.isReachable = false
        sut.fetchPhotoList(for: "Cricket", pageNo: 1)
        XCTAssertTrue(view.didShowErrorNoInternetConnection)
    }
    
    func testOnErrorGeneric() {
        reachability.isReachable = true
        sut.fetchPhotoList(for: "@#$_%", pageNo: 1)
        XCTAssertTrue(view.didShowError)
    }
    
    func testFetchPhotoList() {
        reachability.isReachable = true
        interactor.searchResults = PhotoBaseModel.fakeList()
        sut.fetchPhotoList(for: "@#$_%", pageNo: 1)
        XCTAssert(view.photos.count == 2)
    }
    
    func testFetchPhotoListWithInteractorNull() {
        reachability.isReachable = true
        sut.interactor = nil
        sut.fetchPhotoList(for: "Cricket", pageNo: 1)
        XCTAssertFalse(view.didShowError)
    }
}
