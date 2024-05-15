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
    let rows: [FoodRecipeRowModel]
    
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
        cell.label.text = ingredient
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

