//
//  MainCollectionViewController.swift
//  SeSAC_04_Week
//
//  Created by 김지현 on 2021/10/20.
//

import UIKit
// TableView -> CollectionView
// row -> item
class MainCollectionViewController: UIViewController {

    // 1. collectionview 아울렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = Array(repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.tag = 100
        mainCollectionView.tag = 200
        
        // 3. Delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        // 4. XIB
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        let tagNibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(tagNibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width) - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        tagLayout.minimumInteritemSpacing = tagSpacing //(셀과 셀 사이 간격)
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // 맨 왼쪽 오른쪽 여백
        tagCollectionView.collectionViewLayout = tagLayout
        tagCollectionView.showsHorizontalScrollIndicator = false
        
        
        // collectionview 영역 확인용
        mainCollectionView.backgroundColor = .lightGray
    }
    
    @objc func heartButtonClicked(selectButton: UIButton) {
        print("\(selectButton.tag) 버튼 클릭!")
        
        // 지금과 반대로 설정
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
        //mainCollectionView.reloadData() // 모든 데이터를 다시 로드하는 것 효율x
        mainCollectionView.reloadItems(at: [IndexPath(item: selectButton.tag, section: 0)])
    }
}

// 2. CollectionView Protocol
extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 100 {
            return 10
        } else {
            return mainArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 100 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            
            cell.tagLabel.text = "안녕"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
            
            let item = mainArray[indexPath.item]
            
            cell.mainImageView.backgroundColor = .blue
            
            let image = item == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            cell.heartButton.tag = indexPath.item
            // 버튼 액션 selector로 만드는 방법
            // 매개변수에 heartButton 써주지 않아도 알아서 알아들음
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton:)), for: .touchUpInside)
            
            return cell
            
        }
        
    }
    
    
}

