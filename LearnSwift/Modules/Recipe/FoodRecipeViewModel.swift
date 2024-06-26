//
//  FoodDescriptionViewModel.swift
//  LearnSwift
//
//  Created by Zach on 4/21/24.
//

import Foundation
import UIKit

enum FoodRecipeSection {
    case recipe
    case summary
}

public struct FoodRecipeViewModel {
    var foodRecipe: FoodRecipe?
    
    init(){}
    func getRowModels() -> [FoodRecipeRowModel] {
        guard let foodIngredients = foodRecipe?.foodIngredients else {
            return []
        }
        
        return foodIngredients.map { ingredient in
            return FoodRecipeRowModel(ingredient: ingredient.ingredientName, measurement: ingredient.measurement)
        }
    }
}

struct FoodRecipeSectionModel: Hashable {
    let section: FoodRecipeSection
    let rows: [RecipeRowModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(section)
        hasher.combine(rows)
    }
    
    static func == (lhs: FoodRecipeSectionModel, rhs: FoodRecipeSectionModel) -> Bool {
        let isEqual = lhs.section == rhs.section &&
        lhs.rows == rhs.rows
        
        return isEqual
    }
}

class RecipeRowModel: NSObject {
    func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        fatalError("Should be overriden by subclass")
    }
}

class FoodRecipeRowModel: RecipeRowModel {
    
    var ingredient: String
    var measurement: String
    
    init(ingredient: String, measurement: String) {
        self.ingredient = ingredient
        self.measurement = measurement
    }
    
    override func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reuseIdentifier, for: indexPath) as? RecipeTableViewCell
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "Secondary Grouped Background")
        
        cell.label.textColor = UIColor(named: "Primary Label")
        cell.label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)
        cell.label.text = ingredient
        
        cell.quantity.textColor = UIColor(named: "Primary Label")
        cell.quantity.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)
        cell.quantity.text = measurement
        
        return cell
    }
    
    static func == (lhs: FoodRecipeRowModel, rhs: FoodRecipeRowModel) -> Bool {
        return lhs.ingredient == rhs.ingredient && lhs.measurement == rhs.measurement
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(ingredient)
        hasher.combine(measurement)
        return hasher.finalize()
    }
}

class FoodSummaryRowModel: RecipeRowModel {
    
    var foodItem: FoodItem
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
    }
    
//    override func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Summary")
//        cell.selectionStyle = .none
//        cell.isUserInteractionEnabled = false
//        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.text = foodItem.summary
//
//        //TODO: FIX THE COLOR OF THIS SUMMARY
//
//        cell.textLabel?.textColor = .black
//
//        return cell
//    }
    
    override func getRowCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Summary")
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
        
        var config = cell.defaultContentConfiguration()
        config.text = foodItem.summary
        config.textProperties.color = UIColor(named: "Primary Label") ?? .black
        config.textProperties.font = UIFont.preferredFont(forTextStyle: .subheadline)
        config.textProperties.numberOfLines = 0
        cell.contentConfiguration = config
        
        return cell
    }
    
    static func == (lhs: FoodSummaryRowModel, rhs: FoodSummaryRowModel) -> Bool {
        return lhs.foodItem == rhs.foodItem
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(foodItem)
        return hasher.finalize()
    }
}
