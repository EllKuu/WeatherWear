//
//  ClothingCollectionViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-09.
//

import UIKit

class ClothingItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var clothingImage: UIImageView!
    
    static let identifier = "ClothingItemCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ClothingItemCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with clothing: ClothingItem){
        self.clothingImage.image = UIImage(data: clothing.clothingImage!)
        self.clothingImage.contentMode = .scaleAspectFill
    }

}
