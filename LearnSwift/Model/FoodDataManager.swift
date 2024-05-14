//
//  FoodDataManager.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import Foundation

// Define a class to manage food data
class FoodDataManager {
    
    // Singleton instance
    static let shared = FoodDataManager()
    
    // Data storage for food categories and items
    private var categories: [FoodCategory] = []
    private var items: [FoodItem] = []

    // Method to add a new food category
    func addCategory(id: String = UUID().uuidString, name: String) {
        let category = FoodCategory(id: id, name: name)
        categories.append(category)
    }
    
    // Method to add a new food item
//    func addItem(id: String = UUID().uuidString, name: String, category: FoodCategory) {
//        let item = FoodItem(id: id, name: name, category: category)
//        items.append(item)
//    }
    
    // Method to retrieve all food categories
    func getAllCategories() -> [FoodCategory] {
        return categories
    }
    
    func getCategory(at: Int) {
        
    }
    
    // Method to retrieve all food items for a given category
    func getItemsForCategory(category: FoodCategory) -> [FoodItem] {
        return items.filter { $0.category.id == category.id }
    }
    
    // Method to retrieve all food items
    func getAllItems() -> [FoodItem] {
        return items
    }
    
    func getAllItemsInCategory(category: FoodCategory) -> [FoodItem]{
        return items.filter { $0.category == category}
    }

    
    
    
    
}
