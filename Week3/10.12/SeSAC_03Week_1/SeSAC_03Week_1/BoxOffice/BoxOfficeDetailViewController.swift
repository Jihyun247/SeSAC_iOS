//
//  BoxOfficeDetailViewController.swift
//  SeSAC_03Week_1
//
//  Created by 김지현 on 2021/10/18.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController {
    
//    var movieTitle: String?
//    var releaseDate: String?
//    var runtime: Int?
//    var overview: String?
//    var rate: Double?
    var movieData: Movie?
    let pickerList: [String] = ["감자", "고구마", "파인애플", "자두", "복숭아"]
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = movieData?.title
        overviewTextView.text = movieData?.overview
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
