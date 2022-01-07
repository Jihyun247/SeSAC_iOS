//
//  BeerRecommendViewController.swift
//  SeSAC_Beer
//
//  Created by 김지현 on 2021/12/22.
//

import UIKit

class BeerRecommendViewController: BaseViewController { // 연결
    
    var scrollView = BeerScrollView()
    var bottomView = BeerBottomView()
    
    var viewModel = BeerRecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, "뷰컨")
        // 뷰 모델 바인딩
        
        // baseVC에서 이미 viewdidload 에 configure & setupConstraints 가 호출되어 있기 때문에 다시 호출 안해도 됨
    }
    
    override func configure() {
        
    }
    
    override func setupConstraints() {
        print(#function)
        self.view.addSubview(scrollView)
        self.view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        
        
    }
    
    @objc func refreshBtnClicked() {
        print(#function)
    }
    
    @objc func shareBtnClicked() {
        print(#function)
    }
    
}
