//
//  TabBarController.swift
//  SeSAC_Danggn
//
//  Created by 김지현 on 2021/12/17.
//

import UIKit

class TabBarController: UITabBarController {
    
    let homeVC: ProductTableViewController = {
        let vc = ProductTableViewController()
        vc.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return vc
    }()
    
    let hometownVC: HomeTownViewController = {
        let vc = HomeTownViewController()
        vc.tabBarItem = UITabBarItem(title: "동네생활", image: UIImage(systemName: "building.2"), selectedImage: UIImage(systemName: "building.2.fill"))
        return vc
    }()
    
    let nearVC: NearViewController = {
        let vc = NearViewController()
        vc.tabBarItem = UITabBarItem(title: "내 근처", image: UIImage(systemName: "mappin.circle"), selectedImage: UIImage(systemName: "mappin.circle.fill"))
        return vc
    }()
    
    let chatVC: ChatViewController = {
        let vc = ChatViewController()
        vc.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "bubble.right"), selectedImage: UIImage(systemName: "bubble.right.fill"))
        return vc
    }()
    
    let mypageVC: MypageViewController = {
        let vc = MypageViewController()
        vc.tabBarItem = UITabBarItem(title: "나의 당근", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([homeVC, hometownVC, nearVC, chatVC, mypageVC], animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .black
    }
}
