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
    
    private let highlightView: UIView = {
        let highlight = UIView()
        highlight.alpha = 0.5
        highlight.backgroundColor = .black
        highlight.isHidden = true
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        imageView.tintColor = .white
    
        
        highlight.addSubview(imageView)
        return highlight
    }()
    
    override var isHighlighted: Bool{
        didSet{
            highlightView.isHidden = !isHighlighted
        }
    }
    
    override var isSelected: Bool{
        didSet{
            highlightView.isHidden = !isSelected
        }
    }
    
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
        contentView.addSubview(highlightView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
        highlightView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
