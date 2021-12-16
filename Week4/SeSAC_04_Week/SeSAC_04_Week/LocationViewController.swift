//
//  LocationViewController.swift
//  SeSAC_04_Week
//
//  Created by 김지현 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

/*
 1. 설정 유도
 2. 위경도 -> 주소 변환
 */

class LocationViewController: UIViewController {
    
    @IBOutlet weak var userCurrentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    // 1. CLLocationManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 레이블 관련 정리
        userCurrentLocationLabel.backgroundColor = .red
        userCurrentLocationLabel.alpha = 0
        
        UIView.animate(withDuration: 5) {
            self.userCurrentLocationLabel.alpha = 1
        }
        
        
        

        let location = CLLocationCoordinate2D(latitude: 37.5283169, longitude: 126.9294254)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "HERE"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        // 맵뷰에 어노테이션을 삭제하고자 할 때
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        
        mapView.delegate = self
        
        // 2. delegate 연결
        locationManager.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func alertButtonClicked(_ sender: UIButton) {
        showAlert(title: "설정", message: "설정에서 권한을 허용해주세요", okTitle: "설정으로 이동") {
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url) { success in
                    print("잘 열렸다 \(success)")
                }
            }
        }
    }
    
    @IBAction func updateLabelTextAlert(_ sender: UIButton) {
        showAlert(title: "텍스트 변경", message: "레이블 글자를 바꿉니다", okTitle: "바꾸기") {
            self.userCurrentLocationLabel.text = "바꾸기 완료"
        }
    }

}

// 3.
extension LocationViewController: CLLocationManagerDelegate {
    
    // 9. iOS 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS14 미만
        }
        
        // iOS 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            // 권한 상태 확인 및 권한 요청 가능 (8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
        
    }
    
    // 8. 사용자의 권한 상태 확인 (UDF)
    // 사용자가 위치를 허용했는지 안했는지 거부한건지 이런 권한을 확인 ! (단, iOS 위치 서비스가 가능한지 확인 - 9번)
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            locationManager.startUpdatingLocation() // 위치 접근 시작! => didUpdateLocations 실행
        case .restricted, .denied:
            print("DENIED, 설정으로 유도")
        case .authorizedAlways:
            print("Always")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation() // 위치 접근 시작! => didUpdateLocations 실행
        @unknown default:
            print("DEFAULT")
        }
        
        // iOS14 이상에서는 항상 이걸 고려해야한다
        // 권한요청 세부적으로 조정해야함
        if #available(iOS 14.0, *) {
            // 정확도 체크 : 정확도 감소가 되어 있을 경우, 1시간 4번, 미리 알림, 배터리 오래 슬 수 있음. 워치8
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
                
            }
        }
    }
    
    
    
    // 4. 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = "CURRENT LOCATION"
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            // 10. (중요)
            //locationManager.
        } else {
            print("Location Cannot Find")
        }
    }
    
    // 5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }

    // 6. iOS14 미만 : 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    // 권한이 변경될 때마다 감지해서 실행이 됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    // 7. iOS14 이상 : 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌
    // 권한이 변경될 때마다 감지해서 실행이 됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("나 여기있다")
    }
}
