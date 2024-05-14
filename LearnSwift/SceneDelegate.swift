//
//  SceneDelegate.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //createData()
        showStartScreen()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    private func createData() {
        
        //        let foodDataManager = FoodDataManager.shared
        //
        //        // Add Categories
        //        foodDataManager.addCategory(name: "Appetizers")
        //        foodDataManager.addCategory(name: "Main")
        //        foodDataManager.addCategory(name: "Desserts")
        //        foodDataManager.addCategory(name: "Drinks")
        //
        //        // Add Appetizers
        //        if let appetizerCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Appetizers"}) {
        //            foodDataManager.addItem(name: "Chicken Wings", category: appetizerCategory)
        //            foodDataManager.addItem(name: "Brussell Sprouts", category: appetizerCategory)
        //            foodDataManager.addItem(name: "Calamari", category: appetizerCategory)
        //        }
        //
        //        // Add Mains
        //        if let mainCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Main"}) {
        //            foodDataManager.addItem(name: "Salmon", category: mainCategory)
        //            foodDataManager.addItem(name: "Steak", category: mainCategory)
        //            foodDataManager.addItem(name: "Chicken Picatta", category: mainCategory)
        //        }
        //
        //        // Add Desserts
        //        if let dessertCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Desserts"}) {
        //            foodDataManager.addItem(name: "Ice Cream", category: dessertCategory)
        //            foodDataManager.addItem(name: "Chocolate Cake", category: dessertCategory)
        //            foodDataManager.addItem(name: "Tiramisu", category: dessertCategory)
        //        }
        //        //Add Drinks
        //        if let drinkCategory = foodDataManager.getAllCategories().first(where: {$0.name == "Drinks"}) {
        //            foodDataManager.addItem(name: "Root Beer", category: drinkCategory)
        //            foodDataManager.addItem(name: "Water", category: drinkCategory)
        //            foodDataManager.addItem(name: "Red Bull", category: drinkCategory)
        //        }
        //
        //         Add Descriptions
        //        let categories = foodDataManager.getAllCategories()
        //        let descriptionsArray = getDescriptionsFromFile()
        //        var count = 0
        //        for cat in categories {
        //            let items = foodDataManager.getAllItemsInCategory(category: cat)
        //            for item in items {
        //                //foodDataManager.addDescription(descript: (descriptionsArray?[count])!, foodItem: item)
        //                foodDataManager.addDescription(descript: "I am a description", foodItem: item)
        //                count+=1
        //            }
        //
        //      }
    }
    
    private func getDescriptionsFromFile() -> [String]?{
        let filePath = "Descriptions.rtf"
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8).trimmingCharacters(in: .whitespacesAndNewlines)
            // Split the contents into an array of strings
            let descriptionsArray = fileContents.components(separatedBy: ".")
            
            return descriptionsArray
        } catch {
            // Handle the error, e.g., print an error message
            print("Error reading file: \(error)")
            return nil // Return nil in case of an error
        }
        
    }
    
    private func showStartScreen() {
        guard let window = self.window else {
            fatalError("No window to attach our controller, should never happen")
        }
        
        let navigationController = UINavigationController()
        let router = BaseRouter(viewStackManager: navigationController)
        
        let foodCategoryView = FoodCategoryViewController.instantiateViewController()
        let foodCategoryPresenter = FoodCategoryPresenter(view: foodCategoryView, router: router)
        foodCategoryView.delegate = foodCategoryPresenter
        foodCategoryView.dataSource = foodCategoryPresenter
        
        window.rootViewController = navigationController
        navigationController.push(foodCategoryView, animated: true)
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        // change the root view controller to your specific view controller
        DispatchQueue.main.async {
            window.rootViewController = vc
        }
    }
    
    
}

