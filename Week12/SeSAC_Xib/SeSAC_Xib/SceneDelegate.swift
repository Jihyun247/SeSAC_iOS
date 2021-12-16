//
//  SceneDelegate.swift
//  SeSAC_Xib
//
//  Created by 김지현 on 2021/12/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    /*
     과제
     
     Firebase Analytics, Crashlytics
     (옵션) XIB Custom Class(toss)
     (옵션) Navigation/TabBar Appearence
     
     레이아웃 코드 snapkit, then 사용해서 출시 프로젝트 수정해보기
     */


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print(#function)
        // scene delegate에서 엔트리 씬 지정해주는 방법
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        // 1. Storyboard (컨트롤러 및 관련된 뷰를 정의할 땐(스토리보드) 뷰컨트롤러 클래스를 직접 초기화할 수 없기 때문에 instantiate 을 통해 프로그래밍 방식으로 초기화 한다.)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "vc") as! SnapDetailViewController
        
        // 2. XIB (번들이 무엇인지 정리하기)
//        let bundle = Bundle(for: SettingViewController.self) // Swift Meta Type 문법?
//        let vc = SettingViewController(nibName: "SettingViewController", bundle: bundle)
        
        // 3. Code
//        let vc = SnapDetailViewController()
        
        
        //let nav = UINavigationController(rootViewController: vc)
        
        let vc = TabBarController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible() // iOS13 부터 생김, 꼭 호출해야 함
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print(#function)
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print(#function)
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print(#function)
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print(#function)
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print(#function)
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

