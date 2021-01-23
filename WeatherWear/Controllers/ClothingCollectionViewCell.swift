//
//  ClothingCollectionViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-01-04.
//

import UIKit

class ClothingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ClothingCollectionViewCell"
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public func configure(image: UIImage){
        itemImageView.image = image
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.addSubview(itemImageView)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
