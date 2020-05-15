//
//  ItemCollectionViewCell.swift
//  DiagnalProgrammingTest
//
//  Created by Chetan Girase on 15/05/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    struct CONSTANT {
        static let identifier = "ItemCollectionViewCell"
    }
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLbl: UILabel!
    
    var content: Content? {
        didSet {
            guard let content: Content = content else {return}
            itemTitleLbl.text = content.name 
            itemImageView.image = UIImage(named: content.posterImage) ?? UIImage(named: "placeholder_for_missing_posters")
        }
    }
    
    static func cellIdentifier()-> String {
        return CONSTANT.identifier
    }
}
