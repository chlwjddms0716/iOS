//
//  ViewController.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bookTableView: UITableView!
    
    var bookArray: [Book] = []
    
    let networkManager = NetworkManager.shared
    
    let searchController = UISearchController(searchResultsController:  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookResultViewController") as! BookResultViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupSearchBar()
        setupTableView()
        setupDatas()
    }

    func setupSearchBar(){
        title = "Book Search"
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.autocapitalizationType = .none
    }

    func setupTableView(){
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
        bookTableView.register(UINib(nibName: Cell.bookCellIdentifier, bundle: nil), forCellReuseIdentifier: Cell.bookCellIdentifier)
    }
    
    func setupDatas(){
        
        networkManager.fetchBook { result in
            switch result{
            case .success(let bookData):
                self.bookArray = bookData

                DispatchQueue.main.async {
                    self.bookTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else { return }
        vc.book = bookArray[indexPath.row]
        //vc.modalPresentationStyle = .
        present(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = bookTableView.dequeueReusableCell(withIdentifier: Cell.bookCellIdentifier, for: indexPath) as! BookTableViewCell
        
        cell.rankingLabel.text = bookArray[indexPath.row].ranking
        cell.imageUrl = bookArray[indexPath.row].bookImageURL
        cell.titleLabel.text = bookArray[indexPath.row].title
        cell.publisherLabel.text = bookArray[indexPath.row].publisher
        cell.authorLabel.text = bookArray[indexPath.row].authors
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        
        let vc = searchController.searchResultsController as! BookResultViewController
        vc.keyword = searchController.searchBar.text ?? ""
    }
}
