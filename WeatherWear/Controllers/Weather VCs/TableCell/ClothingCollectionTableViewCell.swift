//
//  ClothingCollectionTableViewCell.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-09.
//

import UIKit

class ClothingCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "ClothingCollectionTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ClothingCollectionTableViewCell", bundle: nil)
    }
    
    func configure(with clothingItem: [ClothingItem]){
        self.clothingItemsSuggestions = clothingItem
        collectionView.reloadData()
    }
    
    @IBOutlet var collectionView: UICollectionView!
    var clothingItemsSuggestions = [ClothingItem]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(ClothingItemCollectionViewCell.nib(), forCellWithReuseIdentifier: ClothingItemCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothingItemsSuggestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothingItemCollectionViewCell.identifier, for: indexPath) as! ClothingItemCollectionViewCell
        
        cell.configure(with: clothingItemsSuggestions[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
    
}
