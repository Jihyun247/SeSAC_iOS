//
//  SearchTableViewCell.swift
//  SeSAC_week6
//
//  Created by 김지현 on 2021/11/03.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    func configureCell(row: UserDiary) {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        let value = format.string(from: row.writeDate)
        
        //img.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        img.contentMode = .scaleAspectFill
        titleLabel.text = row.diaryTitle
        contentLabel.text = row.diaryContent
        dateLabel.text = "\(value)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
