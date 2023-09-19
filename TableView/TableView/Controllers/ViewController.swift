//
//  ViewController.swift
//  TableView
//
//  Created by 최정은 on 2023/08/30.
//

import UIKit

class ViewController: UIViewController {

    var moviesArray: [Movie] = []
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupTableView()
        setupDatas()
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        title = "영화목록"
    }
    
    func setupDatas(){
        movieDataManager.makeMovieData()
        moviesArray = movieDataManager.getMovieData()
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        movieDataManager.updateMovieData()
        moviesArray = movieDataManager.getMovieData()
        
        tableView.reloadData()
        
    }
}


extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용가능한 셀을 꺼낸다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
       // indexPath.section - 그룹으로 만들었을 때 어떤 그룹인지
        // indexPath.row - 몇 번째 행
        let movie = moviesArray[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.descriptionLabel.text = movie.movieDescription
        cell.movieNameLabel.text = movie.movieName
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail"{
            let detailVC = segue.destination as! DetailViewController
            
            let indexPath = sender as! IndexPath
            detailVC.movieData = moviesArray[indexPath.row]
        }
    }
}
