//
//  CatalogCollectionViewCell.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import UIKit

class CatalogCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setupUI(product: Product){
        productNameLabel.text = product.title
        priceLabel.text = "\(product.price ?? 0.0)"
        productDescriptionLabel.text = product.description 
        guard let urlString = product.image, let url = URL(string: urlString) else{return}
    }

}
