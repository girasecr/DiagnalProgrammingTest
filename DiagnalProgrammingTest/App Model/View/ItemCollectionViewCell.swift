//
//  ItemCollectionViewCell.swift
//  DiagnalProgrammingTest
//
//  Created by Deskera User Access on 15/05/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    struct CONSTANT {
        static let identifier = "ItemCollectionViewCell"
    }
    
    static func cellIdentifier()-> String {
        return CONSTANT.identifier
    }
}
