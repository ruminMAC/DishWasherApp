//
//  DishwasherCollectionViewCell.swift
//  Dishwasher
//
//  Created by mac on 5/14/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

protocol DishwasherCellDelegate {
    func finishLoading(string: Bool)
}
class DishwasherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "DishwasherCell"
    static var delegate: DishwasherCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
    }
    
    func configure(with dishwasher: Dishwasher){
        
        titleLabel.text = dishwasher.title
        guard let price = (dishwasher.price)["now"] else { return }
        guard let currency = (dishwasher.price)["currency"] else { return }
        
        priceLabel.text = price + " " + currency
        
        let imageURL = URL(string: "http:\(dishwasher.image)")
        guard let url = imageURL else { return }
            
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    DishwasherCollectionViewCell.delegate?.finishLoading(string: true)
                }
            }catch
            {
                print("Failed getting image")
            }
        }
        
    }
}

