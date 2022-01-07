//
//  ProductTableViewCell.swift
//  SeSAC_Danggn
//
//  Created by 김지현 on 2021/12/17.
//

import UIKit
import SnapKit

class ProductTableViewCell: UITableViewCell {
    
    let productImgView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "당근당근"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "당산동"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "30000원"
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraint() {
        
        self.addSubview(productImgView)
        self.addSubview(productNameLabel)
        self.addSubview(locationLabel)
        self.addSubview(priceLabel)
        
        productImgView.snp.makeConstraints {
            $0.leading.equalTo(20)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
        }

        productImgView.snp.makeConstraints {
            $0.leading.equalTo(20)
        }

        productImgView.snp.makeConstraints {
            $0.leading.equalTo(20)
        }

    }
}
