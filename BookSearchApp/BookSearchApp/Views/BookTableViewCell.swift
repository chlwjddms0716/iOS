//
//  BookTableViewCell.swift
//  BookSearchApp
//
//  Created by 최정은 on 2023/09/19.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var imageUrl: String? {
        didSet{
            loadImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
