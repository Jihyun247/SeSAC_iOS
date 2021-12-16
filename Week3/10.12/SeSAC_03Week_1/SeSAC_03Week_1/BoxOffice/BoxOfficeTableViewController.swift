//
//  BoxOfficeTableViewController.swift
//  SeSAC_03Week_1
//
//  Created by 김지현 on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {
    
    let movieInformation = MovieInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieInformation.movie.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 타입 캐스팅 as전까지는 UITableViewCell 타입으로 반환하게 됨
        // 하지만 as를 통해 타입 캐스팅을 해주어 BoxOfficeTableViewCell로 되는 것
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "boxOfficeCell", for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        // 위 옵셔널바인딩과의 차이 let cell = tableView.dequeueReusableCell(withIdentifier: "boxOfficeCell", for: indexPath) as! BoxOfficeTableViewCell
        
        let row = movieInformation.movie[indexPath.row]
       // 예약어를 변수로 사용하고 싶을 때let `switch` = movieInformation.movie[indexPath.row]
        
        cell.posterImageView.backgroundColor = .red
        cell.posterImageView.image = UIImage(named: row.title)
        cell.titleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        // return UIScreen.main.bounds.height / 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Movie", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as! BoxOfficeDetailViewController
        
        let row = movieInformation.movie[indexPath.row]
        
        
//        vc.releaseDate = row.releaseDate
//        vc.overview = row.overview
//        vc.runtime = row.runtime
//        vc.rate = row.rate
//        vc.movieTitle = row.title
        vc.movieData = row
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
