//
//  LottoViewController.swift
//  SeSAC_Week14
//
//  Created by 김지현 on 2021/12/28.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController { // MVVM 중 View
    
    let viewModel = LottoViewModel() // viewModel
    
    // 로또 번호 1 - 7, 당첨일자, 당첨금액
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
       
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.backgroundColor = .white
        view.distribution = .fillEqually
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetting()
        constraints()
        
        viewModel.lotto1.bind { num in
            self.label1.text = "\(num)"
        }
        viewModel.lotto2.bind { num in
            self.label2.text = "\(num)"
        }
        viewModel.lotto3.bind { num in
            self.label3.text = "\(num)"
        }
        viewModel.lotto4.bind { num in
            self.label4.text = "\(num)"
        }
        viewModel.lotto5.bind { num in
            self.label5.text = "\(num)"
        }
        viewModel.lotto6.bind { num in
            self.label6.text = "\(num)"
        }
        viewModel.lotto7.bind { num in
            self.label7.text = "\(num)"
        }
        viewModel.lottoMoney.bind { money in
            self.moneyLabel.text = "\(money)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchLottoAPI(678)
        }
    }
    
    func uiSetting() {
        
    }
    
    func constraints() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.center.equalTo(view)
            make.height.equalTo(50)
        }
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            $0.backgroundColor = .lightGray
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
        
        view.addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
}
