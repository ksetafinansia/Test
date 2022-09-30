//
//  CatalogCollectionViewCell.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import UIKit
import Kingfisher

class CatalogCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productDescriptionLabel: UILabel!

    //MARK: Variable
    var cornerRadius = 10.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    //MARK: Initial Setup
    func setupUI(product: Product){
        productNameLabel.text = product.title
        priceLabel.text = "\(product.price ?? 0.0)"
        productDescriptionLabel.text = product.description
        ratingLabel.text = "★ \(product.rating.rate ?? 0.0)"
        guard let urlString = product.image, let url = URL(string: urlString) else{return}
        imageView.kf.setImage(with: url)
        setupShadow()
    }
    
    func setupShadow(){
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }

}
