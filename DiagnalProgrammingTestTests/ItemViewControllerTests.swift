//
//  ItemViewControllerTests.swift
//  DiagnalProgrammingTestTests
//
//  Created by Chetan Girase on 17/05/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import DiagnalProgrammingTest

class ItemViewControllerTests: XCTestCase {
    
    var itemViewController:  ItemsViewController!
    
    override func setUp() {
        super.setUp()
        //get the storyboard the ViewController under test is inside
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
        itemViewController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController
        
        //load view hierarchy
        _ = itemViewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSUT_CanInstantiateViewController() {
        XCTAssertNotNil(itemViewController)
    }
    
    func testSUT_CollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(itemViewController.itemCollectionView)
    }
    
    func testSUT_HasItemsForCollectionView() {
        XCTAssertNotNil(itemViewController.viewModel?.itemArray)
    }
    
    func testSUT_ShouldSetCollectionViewDataSource() {
        XCTAssertNotNil(itemViewController.itemCollectionView.dataSource)
    }
    
    func testSUT_ConformsToCollectionViewDataSource() {
        XCTAssertNotNil(itemViewController.itemCollectionView.dataSource)
    }
    
    func testSUT_ShouldSetCollectionViewDelegate() {
        XCTAssertNotNil(itemViewController.itemCollectionView.delegate)
    }
    
    func testSUT_ConformsToCollectionViewDelegate() {
        XCTAssertTrue(itemViewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(itemViewController.responds(to: #selector(itemViewController.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(itemViewController.responds(to: #selector(itemViewController.collectionView(_:cellForItemAt:))))
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        XCTAssertTrue(itemViewController.conforms(to: UICollectionViewDelegateFlowLayout.self))
        XCTAssertTrue(itemViewController.responds(to: #selector(itemViewController.collectionView(_:layout:sizeForItemAt:))))
        XCTAssertTrue(itemViewController.responds(to: #selector(itemViewController.collectionView(_:layout:minimumLineSpacingForSectionAt:))))
        XCTAssertTrue(itemViewController.responds(to: #selector(itemViewController.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))))
    }
}
