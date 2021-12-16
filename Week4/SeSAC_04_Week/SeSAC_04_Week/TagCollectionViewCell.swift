//
//  TagCollectionViewCell.swift
//  SeSAC_04_Week
//
//  Created by 김지현 on 2021/10/20.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"

    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
