//
//  BookResultCollectionViewCell.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import UIKit

class BookResultCollectionViewCell:
    UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageUrl: String? {
        didSet{
            loadImage()
        }
    }
    
    func loadImage() {
        if let imgUrl = imageUrl, let url = URL(string: imgUrl){
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
