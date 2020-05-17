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
    @IBOutlet weak var itemSearchBar: UISearchBar!
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    
    struct CONSTANT {
        static let itemsPerRow: CGFloat = 3
        static let lineSpace: CGFloat = 30
        static let itemInternSpace: CGFloat = 7
        static let defaultSearchBarHeight: CGFloat = 44
    }
    
    private var isSearch = false
    var viewModel: ItemViewModel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        itemCollectionView.delegate = self
        loadModelData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    // MARK: - IBActions
    @IBAction func didTapSearchButton(_ sender: Any) {
        if itemSearchBar.isFirstResponder {
            itemSearchBar.text = ""
            itemSearchBar.resignFirstResponder()
            itemCollectionView.reloadData()
        }
        
        searchBarHeight.constant = searchBarHeight.constant == 0 ? CONSTANT.defaultSearchBarHeight : 0
        //Added animation to constraint
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Collection View Delegate and Datasource
extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch {
            return viewModel?.filteredItmes.count ?? 0
        }
        
        return viewModel?.itemArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.cellIdentifier(), for: indexPath) as! ItemCollectionViewCell
        cell.content = isSearch ? viewModel?.filteredItmes[indexPath.row] : viewModel?.itemArray[indexPath.row]
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        itemSearchBar.resignFirstResponder()
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
        return CGSize(width: collectionWidth/CONSTANT.itemsPerRow - CONSTANT.itemInternSpace, height: collectionHeight/CONSTANT.itemsPerRow - CONSTANT.lineSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CONSTANT.lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CONSTANT.itemInternSpace
    }
}

// MARK: - UISearchbBr Delegate
extension ItemsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true;
        self.itemCollectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.didTapSearchButton(UIButton())
        isSearch = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false;
            self.itemCollectionView.reloadData()
        } else {
            viewModel?.searchItemWith(searchText)
            isSearch = true;
            self.itemCollectionView.reloadData()
        }
    }
}
