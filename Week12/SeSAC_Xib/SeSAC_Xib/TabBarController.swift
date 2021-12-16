//
//  TabBarController.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/15.
//

import UIKit
// NavigationController, TabBarController
// TabBar, TabBarItem(title, image, selectImage), tintColor
// iOS13: UITabBarAppearance (버전에 따른 분기 처리 필요)
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //기능별로 메서드 묶어도 되고 우선 1차원적으로 나열 ㄱ ㄱ
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정 화면"
        firstVC.tabBarItem.image = UIImage(systemName: "star")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        
        let thirdVC = DetailViewController()
        thirdVC.tabBarItem.selectedImage = UIImage(systemName: "person")
        thirdVC.tabBarItem.image = UIImage(systemName: "person.circle")
        thirdVC.tabBarItem.title = "디테일뷰"
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        // 첫번째 두번째 탭바는 네비x, 세번째 탭바엔 네비게이션바 넣어줌
        
        // setViewControllers ???
        setViewControllers([firstVC, secondVC, thirdNav], animated: true)
        
        let appearance = UITabBarAppearance()
        //appearance.configureWithTransparentBackground() // 완전 투명
        //appearance.configureWithOpaqueBackground() // 불투명
        appearance.configureWithDefaultBackground() //
        
        tabBar.standardAppearance = appearance
        //tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        <#code#>
//    }
}
