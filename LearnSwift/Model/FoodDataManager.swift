//
//  FoodDataManager.swift
//  LearnSwift
//
//  Created by Zach on 4/8/24.
//

import Foundation

// Define a class to manage food data
public class FoodDataManager {
    
    // Singleton instance
    public static let shared = FoodDataManager()
    
    // Data storage for food categories and items
    private var categories: [FoodCategory] = []
    private var items: [FoodItem] = []
    private var ingredients: [FoodIngredients] = []
    private var recipes: [FoodRecipe] = []

    // Method to add a new food category
    public func addCategory(id: String = UUID().uuidString, name: String) {
        let category = FoodCategory(id: id, name: name)
        categories.append(category)
    }
    
    // Method to add a new food item
    public func addItem(id: String = UUID().uuidString, name: String, category: FoodCategory, description: String, summary: String) {
        let item = FoodItem(id: id, name: name, category: category, description: description, summary: summary)
        items.append(item)
    }
    
    public func addIngredients(id: String = UUID().uuidString, ingredientName: String, measurement: String) {
        let ingredient = FoodIngredients(id: id, ingredientName: ingredientName, measurement: measurement)
        ingredients.append(ingredient)
    }
    
    public func addRecipe(id: String = UUID().uuidString, foodItem: FoodItem, ingredients: [FoodIngredients]) {
        let recipe = FoodRecipe(id: id, foodItem: foodItem, foodIngredients: ingredients)
        recipes.append(recipe)
    }
    
    // Method to retrieve all food categories
    public func getAllCategories() -> [FoodCategory] {
        return categories
    }
    
    public func getCategory(at: Int) {
        
    }
    
    // Method to retrieve all food items for a given category
    public func getItemsForCategory(category: FoodCategory) -> [FoodItem] {
        return items.filter { $0.category.id == category.id }
    }
    
    // Method to retrieve all food items
    public func getAllItems() -> [FoodItem] {
        return items
    }
    
    public func getAllItemsInCategory(category: FoodCategory) -> [FoodItem]{
        return items.filter { $0.category == category}
    }
    
    public func getAllIngredients() -> [FoodIngredients] {
        return ingredients
    }
    
    public func getRecipeForItem(item: FoodItem) -> FoodRecipe {
        return recipes.first(where: {$0.foodItem == item})!
    }
}
