//
//  FoodItemViewModel.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/11/24.
//

import Foundation
import UIKit

enum FoodItemSection {
    case item
}

public struct FoodItemViewModel {
    var foodItems: [FoodItem]
    var searchFoodItems: [FoodItem] = [FoodItem]()
    
    init(foodCategory: FoodCategory) {
        self.foodItems = FoodDataManager.shared.getItemsForCategory(category: foodCategory)
    }
    
    func getRowModels() -> [FoodItemRowModel] {
        return foodItems.map { foodItem -> FoodItemRowModel in
            return FoodItemRowModel(item: foodItem)
        }
    }
    
    func getSearchRowModels() -> [FoodItemRowModel] {
        return searchFoodItems.map { foodItem -> FoodItemRowModel in
            return FoodItemRowModel(item: foodItem)
        }
    }
}

struct FoodItemSectionModel: Hashable {
    let section: FoodItemSection
    let rows: [FoodItemRowModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(section)
        hasher.combine(rows)
    }

    static func == (lhs: FoodItemSectionModel, rhs: FoodItemSectionModel) -> Bool {
        let isEqual = lhs.section == rhs.section &&
        lhs.rows == rhs.rows
        
        return isEqual
    }
}

class ItemRowModel: NSObject {
    func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        fatalError("Should be overriden by subclass")
    }
}

class FoodItemRowModel: ItemRowModel {
    var item: FoodItem
    
    init(item: FoodItem) {
        self.item = item
    }
    
    override func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = true
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.description
        
        return cell
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(item)
        return hasher.finalize()
    }
    
    static func == (lhs: FoodItemRowModel, rhs: FoodItemRowModel) -> Bool {
        let isEqual = lhs.item == rhs.item
        
        return isEqual
    }
}
