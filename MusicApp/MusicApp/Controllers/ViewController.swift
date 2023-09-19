//
//  ViewController.swift
//  MusicApp
//
//  Created by 최정은 on 2023/09/18.
//

import UIKit

// navigationBar, TableView 추가
// nib 으로 테이블 셀 만들기

class ViewController: UIViewController {

    @IBOutlet weak var musicTable: UITableView!
    
    var webtoonArray: [Webtoon] = []
    
    var networkManager = NetworkManager.shared
    
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupTableView()
        setupDatas()
        setupSearchBar()
    }
    
    func setupSearchBar(){
        title = "Webtoon Search"
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        //첫글자 대문자 설정 없애기
        searchController.searchBar.autocapitalizationType = .none
    }

    func setupTableView(){
        musicTable.dataSource = self
        musicTable.delegate = self
        musicTable.register(UINib(nibName: Cell.musicCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.musicCellIdentifier)
    }
    
    func setupDatas(){
        networkManager.fetchWebtoon(searchTerm: "") { result in
            switch result{
            case .success(let musicData):
                
                // 클로저 내부에서 캡처 현상이 발생할 수 있기 때문에 self를 써야됨
                self.webtoonArray = musicData
                
                // fetchMusic이 비동기 함수여서 ui 변경은 메인쓰레드에서 실행되야함
                DispatchQueue.main.async {
                    self.musicTable.reloadData()
                }
         
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}


extension ViewController: UITableViewDelegate{
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return webtoonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = musicTable.dequeueReusableCell(withIdentifier:  Cell.musicCellIdentifier, for: indexPath) as! MusicCell
        
        
        cell.imageUrl = webtoonArray[indexPath.row].imageUrl
        
        cell.somgNameLabel.text = webtoonArray[indexPath.row].songName
        cell.artistNameLabel.text = webtoonArray[indexPath.row].artistName
        cell.releaseDateLabel.text = "\( webtoonArray[indexPath.row].albumName!)"
        cell.albumNameLabel.text = webtoonArray[indexPath.row].releaseDate
        
        cell.selectionStyle = .none
        return cell
        
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchKeyword = searchController.searchBar.text else { return }
        
        print(searchKeyword)
        self.webtoonArray = []
        
        networkManager.fetchWebtoon(searchTerm: searchKeyword) { result in
            switch result{
            case .success(let webtoonData):
                
                // 클로저 내부에서 캡처 현상이 발생할 수 있기 때문에 self를 써야됨
                self.webtoonArray = webtoonData
                
                // fetchMusic이 비동기 함수여서 ui 변경은 메인쓰레드에서 실행되야함
                DispatchQueue.main.async {
                    self.musicTable.reloadData()
                }
         
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.webtoonArray = []
        
        networkManager.fetchWebtoon(searchTerm: "") { result in
            switch result{
            case .success(let musicData):
                
                // 클로저 내부에서 캡처 현상이 발생할 수 있기 때문에 self를 써야됨
                self.webtoonArray = musicData
                
                // fetchMusic이 비동기 함수여서 ui 변경은 메인쓰레드에서 실행되야함
                DispatchQueue.main.async {
                    self.musicTable.reloadData()
                }
         
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    // 유저가 글자를 입력하는 순간마다 호출되는 메서드 ===> 일반적으로 다른 화면을 보여줄때 구현
    func updateSearchResults(for searchController: UISearchController) {
        print("서치바에 입력되는 단어", searchController.searchBar.text ?? "")
        // 글자를 치는 순간에 다른 화면을 보여주고 싶다면 (컬렉션뷰를 보여줌)
        let vc = searchController.searchResultsController as! SearchResultViewController
        // 컬렉션뷰에 찾으려는 단어 전달
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
    
    
}
