//
//  MainMovieTableViewCell.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/21.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {
    
    static let identifier = "MainMovieTableViewCell"
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var engTitleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var korTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
