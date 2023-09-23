//
//  BookDetailViewController.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let networkManager = NetworkManager.shared
    
    var book: Book? {
        didSet{
            setupData()
            loadImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let book = book{
            titleLabel.text = book.title
            authorLabel.text = book.authors
            publisherLabel.text = book.publisher
        }
    }
    
    func setupData(){
        if let book = book, let bookISBN = book.isbn {
            
            networkManager.getBookDescription(isbn: bookISBN ){ result in
                switch result{
                case .success(let bookData):
                   
                print(bookData)
                    DispatchQueue.main.async {
                        self.descriptionLabel.text = bookData
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadImage() {
        if let book = book, let imgUrl = book.bookImageURL, let url = URL(string: imgUrl){
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.coverImageView.image = image
                        }
                    }
                }
            }
        }
    }
}
