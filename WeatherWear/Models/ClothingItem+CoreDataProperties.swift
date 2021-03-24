//
//  ClothingItem+CoreDataProperties.swift
//  WeatherWear
//
//  Created by elliott kung on 2021-03-24.
//
//

import Foundation
import CoreData


extension ClothingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClothingItem> {
        return NSFetchRequest<ClothingItem>(entityName: "ClothingItem")
    }

    @NSManaged public var clothingBrand: String?
    @NSManaged public var clothingCategory: String?
    @NSManaged public var clothingColor: String?
    @NSManaged public var clothingId: String?
    @NSManaged public var clothingImage: Data?
    @NSManaged public var clothingSeason: [String]?
    @NSManaged public var clothingSubCategory: String?

}

extension ClothingItem : Identifiable {

}
