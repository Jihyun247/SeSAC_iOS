//
//  SampleViewController.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/28.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import SwiftUI

class SampleViewController: UIViewController {
    
    // MARK: - 변수
    var movieData: [Movie] = []
    let uiSettingClass = UISetting()
    
    // 페이징
    var startPage = 1
    var totalCount = 0
    
    // 검색 키워드
    var text = "해리포터"
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -  background color
        
        //self.view.backgroundColor = UIColor(cgColor: CGColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
        tableView.backgroundColor = .clear
        
        // - navigation bar item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeItemTapped))
        navigationItem.title = "영화 검색"
    
        
        // - tableview + tableview cell
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        let nibName = UINib(nibName: SearchMovieTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        
        // - searchbar
        
        //searchController.searchResultsUpdater = self
        searchBar.delegate = self
        //searchBar.barTintColor = .white
        
        // - naver
        loadMovieData()
    }
    

    
    // MARK: - func
    
    @objc func closeItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func loadMovieData() {
        SearchAPIManager.shared.fetchSearchData(text: text, startPage: startPage, totalCount: totalCount) { code, json in

            self.totalCount = json["total"].intValue

            for item in json["items"].arrayValue {
                let korTitle = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                let engTitle = item["subtitle"].stringValue
                let releaseDate = item["pubDate"].stringValue
                let rate = item["userRating"].stringValue
                let starring = item["actor"].stringValue
                let backdropImage = item["image"].stringValue
                //let totalData = item

                let data = Movie(engTitle: engTitle, korTitle: korTitle, releaseDate: releaseDate, genre: "없음", region: "없음", overview: "없음", rate: Double(rate)!, starring: starring, backdropImage: backdropImage)

                self.movieData.append(data)
            }

            self.tableView.reloadData()

        }
    }
}

// MARK: - TableView

extension SampleViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as? SearchMovieTableViewCell else { return UITableViewCell() }
        
        let row = movieData[indexPath.row]
        print(row.korTitle, row.releaseDate, row.overview)
        if let url = URL(string: row.backdropImage) {
            cell.movieImageView.kf.setImage(with: url)
        } else {
            cell.movieImageView.image = UIImage(systemName: "star")
        }
        cell.backgroundColor = .clear
        
        // 값이 변하는 오브젝만 코드로 ui 세팅하고, 변하지 않는건 스토리보드에서 세팅,, ,
        uiSettingClass.labelSetting(cell.movieTitleLabel, row.korTitle, 17, "bold", 0, .black)
        uiSettingClass.labelSetting(cell.movieReleaseLabel, row.releaseDate, 15, "system", 0, .black)
        uiSettingClass.labelSetting(cell.movieOverviewLabel, row.overview, 13, "system", 0, .gray)
        
        cell.movieImageView.contentMode = .scaleAspectFill
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 7
    }
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 2 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                
                loadMovieData()
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    // 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    

}

extension SampleViewController: UISearchBarDelegate, UISearchControllerDelegate {

    // 검색버튼(키보드 리턴키)를 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            self.text = text
            // 검색 결과 데이터 초기화, 페이징도 초기화
            movieData.removeAll()
            startPage = 1
            loadMovieData()
        }
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
    
    // 취소버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에서 커서 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        // 애플 연락처 처럼 animation
        searchBar.showsCancelButton = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
