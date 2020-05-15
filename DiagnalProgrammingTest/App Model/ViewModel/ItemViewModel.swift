//
//  ItemViewModel.swift
//  DiagnalProgrammingTest
//
//  Created by Chetan Girase on 15/05/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation

class ItemViewModel {
    // MARK: - Properties
    private var pageModel: Page?
    private var loadMorePage = 1
    var updateUI: () -> Void = { }
    var navTitle: String = ""
    var itemArray: [Content] = []
    
    init() {
    }
    
    // MARK: - Required Methods
    func loadApiData() {
        self.getApiData(complete: { [weak self] (pageModel) in
            self?.pageModel = pageModel
            self?.preparedTableCellCount()
            self?.updateUI()
        })
    }
    
    func loadMorePageData() {
        if loadMorePage < Constants.loadMoreTotalPage {
            loadMorePage += 1
            loadApiData()
        }
    }
    
    private func preparedTableCellCount() {
        self.itemArray += self.pageModel?.contentItems.content ?? []
        self.navTitle = self.pageModel?.title ?? ""
    }
    
    private func getApiData(complete:@escaping (Page?) -> Void) {
        let resourcePageName = "CONTENTLISTINGPAGE-PAGE\(loadMorePage)"
        
        RequestManager.sharedInstance.getAPIData(forResource: resourcePageName, ofType:  "json") { (data, _) in
            if let response = data {
                let jsonData = response
                let pageModel = try? JSONDecoder().decode(PageModel.self, from: jsonData)
                complete(pageModel?.page)
            } else {
                complete(nil)
            }
        }
    }
}
