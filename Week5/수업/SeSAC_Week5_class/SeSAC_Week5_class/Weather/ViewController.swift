//
//  ViewController.swift
//  SeSAC_Week5_class
//
//  Created by 김지현 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import CoreLocation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var curDegreeLabel: UILabel!
    @IBOutlet weak var curHumidity: UILabel!
    @IBOutlet weak var curWindSpeedLabel: UILabel!
    @IBOutlet weak var happyDayLabel: UILabel!
    

    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 왜 뒤에 놔도 맨 앞에 떠 !
        //backgroundImageView.image = UIImage(named: "background")
        //backgroundImageView.contentMode = .scaleAspectFill
        view.backgroundColor = .brown
        
        imageViewSetting(locationImageView, imgName: "location.fill", imgColor: .white)
        
        buttonSetting(shareButton, imgName: "square.and.arrow.up", imgColor: .white)
        buttonSetting(refreshButton, imgName: "goforward", imgColor: .white)
        
        
        shadowAndRadius(curDegreeLabel, 0, UIColor.clear.cgColor, 0, 10, true)
        shadowAndRadius(curHumidity, 0, UIColor.clear.cgColor, 0, 10, true)
        shadowAndRadius(curWindSpeedLabel, 0, UIColor.clear.cgColor, 0, 10, true)
        shadowAndRadius(happyDayLabel, 0, UIColor.clear.cgColor, 0, 10, true)
        
        getCurrentWeather()
    }
    
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        getCurrentWeather()
        print("날씨 새로고침")
    }
    
    func getCurrentWeather() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 HH시 mm분"
        let todayString = formatter.string(from: Date())
        
        
        
        // 위경도->주소 변환 끝낸다음에 트렌드 미디어 끝내자 !!
        
        WeatherAPIManager.shared.fetchWeatherData() { code, json in
            
            let latitude = json["coord"]["lat"].doubleValue
            let longitude = json["coord"]["lon"].doubleValue
            let currentTemp = json["main"]["temp"].doubleValue - 273.15
            let humidity = json["main"]["humidity"].intValue
            let windSpeed = json["wind"]["speed"].doubleValue
            // 아놔 왜 얘만 배열에 한번 더 싸여있는데 ~
            let iconImgNum = json["weather"][0]["icon"].stringValue
            let imgUrl = "https://openweathermap.org/img/wn/\(iconImgNum)@2x.png"
            // 옵셔널 가능성 있으면 double, 옵셔널 아니면 doubleValue
            self.curDegreeLabel.text = "\(Int(currentTemp))"
            
            let curLocation = CLLocation(latitude: latitude, longitude: longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(curLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
                if let address: [CLPlacemark] = placemarks {
                    if let name = address.first?.name {
                        self.labelSetting(self.locationLabel, name, 23, "system", 0, textColor: .white)
                    }
                }
            })
            
            self.labelSetting(self.todayDateLabel, todayString, 17, "system", 0, textColor: .white)
            
            self.labelSetting(self.curDegreeLabel, "지금은 \(Int(currentTemp))도 에요", 20, "bold", 0, textColor: .black, backColor: .white)
            self.labelSetting(self.curHumidity, "\(humidity)% 만큼 습해요", 20, "bold", 0, textColor: .black, backColor: .white)
            self.labelSetting(self.curWindSpeedLabel, "\(round(windSpeed*10000000000)/10000000000)m/s의 바람이 불어요", 20, "bold", 0, textColor: .black, backColor: .white)
            self.labelSetting(self.happyDayLabel, "오늘도 행복한 하루 보내세요", 20, "bold", 0, textColor: .black, backColor: .white)
            
            if let url = URL(string: imgUrl) {
                self.weatherImageView.kf.setImage(with: url)
                self.weatherImageView.backgroundColor = .white
                self.weatherImageView.clipsToBounds = true
                self.weatherImageView.layer.cornerRadius = 15
            } else {
                self.weatherImageView.image = UIImage(systemName: "star")
                self.weatherImageView.backgroundColor = .white
                self.weatherImageView.clipsToBounds = true
                self.weatherImageView.layer.cornerRadius = 15
            }
        }
    }
    
    func labelSetting(_ label: UILabel, _ text: String, _ textSize: Int, _ textStyle: String, _ line: Int, textColor: UIColor, backColor: UIColor = .clear) {
        label.text = text
        label.textColor = textColor
        label.backgroundColor = backColor
        
        if textStyle == "system" {
            label.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        } else if textStyle == "bold" {
            label.font = UIFont.boldSystemFont(ofSize: CGFloat(textSize))
        }
        
        label.numberOfLines = line
    }
    
    func imageViewSetting(_ imgView: UIImageView, imgName: String, imgColor: UIColor = .clear) {
        imgView.image = UIImage(systemName: imgName)
        imgView.tintColor = imgColor
    }
    
    func buttonSetting(_ btn: UIButton, imgName: String, imgColor: UIColor) {
        btn.imageView?.image = UIImage(systemName: imgName)
        btn.tintColor = imgColor
    }
    
    func shadowAndRadius(_ view: UIView, _ shadowOpacity: Float, _ shadowColor: CGColor, _ shadowRadius: CGFloat, _ cornerRadius: CGFloat, _ clipsToBounds: Bool) {
        
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowColor = shadowColor
        //view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = shadowRadius
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = clipsToBounds
        
    }


}

