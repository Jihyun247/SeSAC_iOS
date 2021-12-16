//
//  MovieListViewController.swift
//  TrendMedia
//
//  Created by 김지현 on 2021/10/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - 변수
    let movieData = MovieData()
    let uiSettingClass = UISetting()
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBarButtonItem: UIBarButtonItem!
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarButtonItem.image = UIImage(systemName: "magnifyingglass")
        searchBarButtonItem.tintColor = .black

        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        let nibName = UINib(nibName: MainMovieTableViewCell.identifier, bundle: nil)
        movieTableView.register(nibName, forCellReuseIdentifier: MainMovieTableViewCell.identifier)
    }
    
    // MARK: - IBAction
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        // 스토리보드 특정
        let sb = UIStoryboard(name: "Main", bundle: nil)
        // 스토리보드 내 뷰컨 가져오기, nav 임베드
        let vc = sb.instantiateViewController(withIdentifier: "SampleViewController") as! SampleViewController
        
        // present로 띄우더라도 코드로 nav 임베드 하면 네비게이션바 이용 가능
        // presentModally 처럼 띄워져도 네비바 이용 가능 -> ex) 인스타 내에서 웹서핑 등
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        // present
        present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - func
    
    
}

// MARK: - extension

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieTableViewCell.identifier, for: indexPath) as? MainMovieTableViewCell else { return UITableViewCell() }
        
        let row = movieData.movie[indexPath.row]
        
        // 값이 변하는 오브젝만 코드로 ui 세팅하고, 변하지 않는건 스토리보드에서 세팅,, ,
        uiSettingClass.labelSetting(cell.engTitleLabel, row.engTitle, 17, "bold", 0)
        uiSettingClass.labelSetting(cell.korTitleLabel, row.korTitle, 20, "bold", 0)
        uiSettingClass.labelSetting(cell.rateLabel, String(row.rate), 13, "system", 0)
        uiSettingClass.labelSetting(cell.genreLabel, "#\(row.genre)", 13, "system", 0, .gray)
        uiSettingClass.labelSetting(cell.releaseDateLabel, row.releaseDate, 13, "system", 0, .gray)
        
        // ㅜ이거맞나...?
        let assetName: String = row.engTitle.replacingOccurrences(of: "&", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "  ", with: " ").replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "-", with: "_").lowercased()
        cell.posterImageView.image = UIImage(named: assetName)
        cell.posterImageView.contentMode = .scaleAspectFill
        
        uiSettingClass.shadowAndRadius(cell.cardView, 0, UIColor.clear.cgColor, 0, 10, true)
        uiSettingClass.shadowAndRadius(cell.shadowView, 0.4, UIColor.black.cgColor, 10, 10, false)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return movieTableView.bounds.height * 0.8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    
}
