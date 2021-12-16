//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class SearchViewController: UIViewController {
    
    // MARK: - 변수
    var movieData: [Movie] = []
    let uiSettingClass = UISetting()
    //var resultMovieData: Movie = .init(engTitle: <#T##String#>, korTitle: <#T##String#>, releaseDate: <#T##String#>, genre: <#T##Genre#>, region: <#T##String#>, overview: <#T##String#>, rate: <#T##Double#>, starring: <#T##String#>, backdropImage: <#T##ImageUrl#>)
    
    // 페이징
    var startPage = 1
    var totalCount = 0
    
    // 검색 키워드
    var query = ""
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // - navigation bar item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeItemTapped))
        
        // search bar 넣는 방법
        // 1. search bar 그냥 넣기
        // 2. UISearchController 넣기 (tableview에 결과를 전달해야 하므로 컨트롤러 필요)
        
        // navigation bar 의 titleview에 search bar을 넣을 땐 너비 사이즈를 지정해주지 않아도 알아서 자리를 잡음
        // 하지만 barbuttonitem으로 넣으려면 frame을 정해주어야 한다
        //let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: 60))
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화 제목을 검색하세요"
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.8, height: 60)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchController.searchBar)
        
        // 더 해볼 것 : searchbar height, searchbar text custom
        
        // -  background color
        
        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1))
        searchResultTableView.backgroundColor = .clear
    
        
        // - tableview + tableview cell
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.prefetchDataSource = self
        
        let nibName = UINib(nibName: SearchMovieTableViewCell.identifier, bundle: nil)
        searchResultTableView.register(nibName, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        
        // - searchbar
        
        searchController.delegate = self
        //searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        
        // - naver
        //fetchMovieData()

    }
    
    // MARK: - IBAction
    
    // 음 왜 안먹지
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    // MARK: - func
    
    @objc func closeItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData(query: String) {
        
        // 쿼리에 문제가 없을 때 실행해라 !
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=\(startPage)"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": "sKd1gAvfaou8JKuQX1O8",
                "X-Naver-Client-Secret": "7uVQRpbcGR"]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
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
                    
                    DispatchQueue.main.async {
                        self.searchResultTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
    }

}

// MARK: - TableView

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as? SearchMovieTableViewCell else { return UITableViewCell() }
        
        let row = movieData[indexPath.row]
        if let url = URL(string: row.backdropImage) {
            cell.movieImageView.kf.setImage(with: url)
        } else {
            cell.movieImageView.image = UIImage(systemName: "star")
        }
        cell.backgroundColor = .clear
        
        // 값이 변하는 오브젝만 코드로 ui 세팅하고, 변하지 않는건 스토리보드에서 세팅,, ,
        uiSettingClass.labelSetting(cell.movieTitleLabel, row.korTitle, 17, "bold", 0, .white)
        uiSettingClass.labelSetting(cell.movieReleaseLabel, row.releaseDate, 15, "system", 0, .white)
        uiSettingClass.labelSetting(cell.movieOverviewLabel, row.overview, 15, "system", 0, .lightGray)
        
        // ㅜ이거맞나...?
        let assetName: String = row.engTitle.replacingOccurrences(of: "&", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "  ", with: " ").replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_").lowercased()
        cell.movieImageView.contentMode = .scaleAspectFill
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return searchResultTableView.bounds.height / 6
    }
    
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if movieData.count - 2 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                fetchMovieData(query: query)
                print("prefetch: \(indexPath)")
            }
        }
    }
    
    // 취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소: \(indexPaths)")
    }
    
    

}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate {

    // 검색버튼(키보드 리턴키)를 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            self.query = text
            // 검색 결과 데이터 초기화, 페이징도 초기화
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: query)
        }
        
        // 얘 왜 안먹지 ??
        view.endEditing(true)
    }
    
    // 취소버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        searchResultTableView.reloadData()
        searchBar.setShowsScope(false, animated: true)
    }
    
    // 서치바에서 커서 깜빡이기 시작할 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        // 애플 연락처 처럼 animation
        searchBar.showsCancelButton = true
        searchBar.setShowsScope(true, animated: true)
    }
}
