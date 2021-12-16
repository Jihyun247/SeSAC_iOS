//
//  SearchMovieTableViewCell.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/24.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    static let identifier = "SearchMovieTableViewCell"
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
