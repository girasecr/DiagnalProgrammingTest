//
//  ItemsViewController.swift
//  DiagnalProgrammingTest
//
//  Created by Chetan Girase on 15/05/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    // MARK: - Properties/Constant
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    var viewModel: ItemViewModel?
    private let itemsPerRow: CGFloat = 3
    private let lineSpace: CGFloat = 45
    private let itemInternSpace: CGFloat = 10
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        itemCollectionView.delegate = self
        loadModelData()
    }
    
    // MARK: - Required Methods
    private func loadModelData() {
        viewModel = ItemViewModel()
        observeEvents()
        viewModel?.loadApiData()
    }
    
    private func observeEvents() {
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.title = self?.viewModel?.navTitle
                self?.itemCollectionView.reloadData()
            })
        }
    }
}

// MARK: - Collection View Delegate and Datasource
extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.itemArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.cellIdentifier(), for: indexPath) as! ItemCollectionViewCell
        cell.content = viewModel?.itemArray[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let tableHeight = itemCollectionView.bounds.size.height
        let contentHeight = itemCollectionView.contentSize.height
        let insetHeight = itemCollectionView.contentInset.bottom
        
        let yOffset = itemCollectionView.contentOffset.y
        let yOffsetAtBottom = yOffset + tableHeight - insetHeight
        
        if (yOffsetAtBottom >= contentHeight) {
            viewModel?.loadMorePageData()
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        let collectionHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth/itemsPerRow - itemInternSpace, height: collectionHeight/itemsPerRow - lineSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemInternSpace
    }
}
