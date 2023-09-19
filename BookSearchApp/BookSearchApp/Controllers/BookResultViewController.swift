//
//  BookResultViewController.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import UIKit

class BookResultViewController: UIViewController {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    let flowLayout = UICollectionViewFlowLayout()
    
    let networkManager = NetworkManager.shared
    
    var bookArray: [Book] = []
    
    var keyword: String? {
        didSet{
            setupDatas(keyword: keyword)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    func setupCollectionView(){
        
        bookCollectionView.dataSource = self
        
        flowLayout.scrollDirection = .vertical
        
        let collectionCellWidth = (UIScreen.main.bounds.width - CVCell.spacingWitdh * (CVCell.cellColumns - 1)) / CVCell.cellColumns
        
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth + 50)
        // 아이템 사이 간격 설정
        flowLayout.minimumInteritemSpacing = CVCell.spacingWitdh
        // 아이템 위아래 사이 간격 설정
        flowLayout.minimumLineSpacing = CVCell.spacingWitdh
        
        // 컬렉션뷰의 속성에 할당
        bookCollectionView.collectionViewLayout = flowLayout
    }
    
    func setupDatas(keyword: String?){
        
        guard let keyword = keyword else { return }
        
        networkManager.searchBook (keyword: keyword){ result in
            switch result{
            case .success(let bookData):
                self.bookArray = bookData

                DispatchQueue.main.async {
                    self.bookCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension BookResultViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  bookArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: Cell.bookResultCellIdentifier, for: indexPath) as! BookResultCollectionViewCell
        
        cell.imageUrl = bookArray[indexPath.row].bookImageURL
        cell.titleLabel.text = bookArray[indexPath.row].title
        
        return cell
        
    }
    
    
}

