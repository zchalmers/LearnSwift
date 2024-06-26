//
//  FoodItemViewModel.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation
import UIKit

enum FoodCategorySection {
    case category
}

public struct FoodCategoryViewModel {
    var foodCategories: [FoodCategory]?
    
    init() {}
    
    func getRowModels() -> [FoodCategoryRowModel] {
        guard let foodCategories else { return [FoodCategoryRowModel]() }
        
        return foodCategories.map { foodCategory -> FoodCategoryRowModel in
            return FoodCategoryRowModel(category: foodCategory)
        }
    }
}

struct FoodCategorySectionModel: Hashable {
    let section: FoodCategorySection
    let rows: [FoodCategoryRowModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(section)
        hasher.combine(rows)
    }

    static func == (lhs: FoodCategorySectionModel, rhs: FoodCategorySectionModel) -> Bool {
        let isEqual = lhs.section == rhs.section &&
        lhs.rows == rhs.rows
        
        return isEqual
    }
}

class CategoryRowModel: NSObject {
    func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        fatalError("Should be overriden by subclass")
    }
}

class FoodCategoryRowModel: CategoryRowModel {
    var category: FoodCategory
    
    init(category: FoodCategory) {
        self.category = category
    }
    
    override func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = category.name
        cell.textLabel?.textColor = UIColor(named: "Primary Label")
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        
        return cell
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(category)
        return hasher.finalize()
    }
    
    static func == (lhs: FoodCategoryRowModel, rhs: FoodCategoryRowModel) -> Bool {
        let isEqual = lhs.category == rhs.category
        
        return isEqual
    }
}
