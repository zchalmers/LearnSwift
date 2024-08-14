//
//  LearnSwiftNetworkServiceMock.swift
//  LearnSwiftTests
//
//  Created by Chalmers on 8/12/24.
//

import Foundation
import LearnSwift

public class LearnSwiftNetworkServiceMock: LearnSwiftService {
    let foodDataManager = FoodDataManager.shared
    
    public func fetchFoodCategories() async throws -> [LearnSwift.FoodCategory] {
        return foodDataManager.getAllCategories()
    }
    
    public func fetchFoodItems(foodCategory: LearnSwift.FoodCategory) async throws -> [LearnSwift.FoodItem] {
        return foodDataManager.getItemsForCategory(category: foodCategory)
    }
    
    public func fetchFoodRecipe(foodItem: LearnSwift.FoodItem) async throws -> LearnSwift.FoodRecipe {
        return foodDataManager.getRecipeForItem(item: foodItem)
    }
    
    public func createData() {
        
        // Add Categories
        foodDataManager.addCategory(name: "Appetizers")
        foodDataManager.addCategory(name: "Main")
        foodDataManager.addCategory(name: "Desserts")
        foodDataManager.addCategory(name: "Drinks")
        
        // Add Appetizers
        if let appetizerCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Appetizers"}) {
            foodDataManager.addItem(name: "Bruschetta", category: appetizerCategory, description: "Toasted bread topped with diced tomatoes, garlic, basil, and olive oil.", summary: "Combine diced tomatoes, minced garlic, chopped basil, and olive oil in a bowl. Season with salt and pepper to taste. Allow the mixture to sit for about 15 minutes to let the flavors meld together. Toast the French baguette slices until lightly golden. Spoon the tomato mixture onto the toasted bread slices and serve immediately.")
            foodDataManager.addItem(name: "Mozzarella Sticks", category: appetizerCategory, description: "Breaded and fried mozzarella cheese sticks served with marinara sauce.", summary: "Preheat the oil for frying to 350°F (175°C). In one shallow dish, place the breadcrumbs. In another shallow dish, beat the eggs. Dip each mozzarella stick into the beaten eggs, then coat evenly with breadcrumbs. Repeat for a thicker coating if desired. Fry the coated mozzarella sticks in the hot oil until golden brown, about 1-2 minutes. Serve hot with marinara sauce for dipping.")
            foodDataManager.addItem(name: "Shrimp Cocktail", category: appetizerCategory, description: "Chilled shrimp served with cocktail sauce and lemon wedges.", summary: "Bring a pot of salted water to a boil. Add the shrimp and cook until pink and opaque, about 2-3 minutes. Drain the shrimp and transfer to a bowl of ice water to cool quickly. In another bowl, mix together ketchup, prepared horseradish, and lemon juice to make the cocktail sauce. Serve the chilled shrimp with cocktail sauce and lemon wedges on the side.")
        }
        
//        if let appetizerCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Appetizers"}) {
//            foodDataManager.addItem(name: "Appetizer 1", category: appetizerCategory, description: "Appetizer 1 Description", summary: "Appetizer 1 Summary")
//            foodDataManager.addItem(name: "Appetizer 2", category: appetizerCategory, description: "Appetizer 2 Description", summary: "Appetizer 2 Summary")
//            foodDataManager.addItem(name: "Appetizer 3", category: appetizerCategory, description: "Appetizer 3 Description", summary: "Appetizer 3 Summary")
//        }
        
        // Add Mains
        if let mainCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Main"}) {
            foodDataManager.addItem(name: "Grilled Salmon with Lemon Butter Sauce", category: mainCategory, description: "Fresh salmon fillet grilled to perfection and served with a tangy lemon butter sauce.", summary: "Preheat the grill to medium-high heat. Season the salmon fillet with salt and pepper to taste. Place the salmon on the grill and cook for about 4-5 minutes per side, or until cooked through and grill marks appear. In a small saucepan, melt the butter over medium heat. Stir in the lemon juice and chopped parsley. Cook for 1-2 minutes until heated through. Serve the grilled salmon drizzled with the lemon butter sauce.")
            foodDataManager.addItem(name: "Beef Tenderloin Steak with Red Wine Reduction", category: mainCategory, description: "Tender beef tenderloin steak cooked to your preference and topped with a rich red wine reduction sauce.", summary: "Season the beef tenderloin steaks with salt and pepper to taste. Heat a skillet over medium-high heat and add the butter. Once melted, add the minced shallot and garlic, and sauté until softened. Add the beef tenderloin steaks to the skillet and cook to your preferred doneness, about 4-5 minutes per side for medium-rare. Remove the steaks from the skillet and set aside to rest. In the same skillet, pour in the red wine and beef broth. Bring to a simmer and cook until the liquid reduces by half, stirring occasionally. Serve the beef tenderloin steaks topped with the red wine reduction sauce.")
            foodDataManager.addItem(name: "Roast Chicken with Garlic and Herbs", category: mainCategory, description: "Juicy roasted chicken seasoned with garlic, herbs, and spices.", summary: "Preheat the oven to 375°F (190°C). In a small bowl, mix together minced garlic, chopped rosemary, chopped thyme, and olive oil to make a paste. Rub the herb mixture all over the chicken, including under the skin. Season the chicken generously with salt and pepper. Place the chicken in a roasting pan and roast for about 1 hour and 15 minutes, or until the juices run clear and the internal temperature reaches 165°F (75°C). Let the chicken rest for 10 minutes before carving.")
        }
        
//        if let mainCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Main"}) {
//            foodDataManager.addItem(name: "Main 1", category: mainCategory, description: "Main 1 Description", summary: "Main 1 Summary")
//            foodDataManager.addItem(name: "Main 2", category: mainCategory, description: "Main 2 Description", summary: "Main 2 Summary")
//            foodDataManager.addItem(name: "Main 3", category: mainCategory, description: "Main 3 Description", summary: "Main 3 Summary")
//        }
        
        // Add Desserts
        if let dessertCategory = foodDataManager.getAllCategories().first(where: { $0.name == "Desserts"}) {
            foodDataManager.addItem(name: "Apple Pie with Vanilla Ice Cream", category: dessertCategory, description: "Classic American dessert made with sweet apple filling baked in a flaky pastry crust, served with a scoop of vanilla ice cream.", summary: "Preheat the oven to 375°F (190°C). In a large mixing bowl, toss sliced Granny Smith apples with granulated sugar, all-purpose flour, ground cinnamon, ground nutmeg, salt, and lemon juice until evenly coated. Roll out the pie crust and line a pie dish with it. Pour the apple mixture into the pie crust. Cover the pie with the remaining pie crust, crimping the edges to seal. Brush the top crust with beaten egg and sprinkle with granulated sugar. Cut a few slits in the top crust to allow steam to escape. Bake for 45-50 minutes or until the crust is golden brown and the filling is bubbly. Let cool slightly before serving with a scoop of vanilla ice cream.")
            foodDataManager.addItem(name: "Chocolate Lava Cake", category: dessertCategory, description: "Warm chocolate cake with a gooey molten center, served with vanilla ice cream.", summary: "Preheat the oven to 425°F (220°C). Grease and flour individual ramekins. In a small bowl, sift together all-purpose flour, cocoa powder, baking powder, and salt. In a separate heatproof bowl, melt the unsalted butter and chopped semi-sweet chocolate together over a double boiler or in the microwave. Remove from heat and stir in granulated sugar until combined. Beat in eggs, one at a time, then add vanilla extract. Gently fold in the dry ingredients until just combined. Divide the batter evenly among the prepared ramekins. Bake for 12-14 minutes, until the edges are set but the center is still soft. Let cool for a few minutes, then run a knife around the edges and invert onto plates. Serve warm with a scoop of vanilla ice cream.")
            foodDataManager.addItem(name: "Tiramisu", category: dessertCategory, description: "Italian dessert made with layers of coffee-soaked ladyfingers and mascarpone cheese, dusted with cocoa powder.", summary: "In a mixing bowl, beat heavy cream until stiff peaks form. In another bowl, whisk together mascarpone cheese, granulated sugar, and vanilla extract until smooth. Gently fold the whipped cream into the mascarpone mixture until well combined. In a shallow dish, combine brewed coffee and coffee liqueur. Quickly dip each ladyfinger into the coffee mixture, making sure not to soak them too long. Arrange a layer of soaked ladyfingers in the bottom of a serving dish. Spread half of the mascarpone mixture over the ladyfingers. Repeat with another layer of soaked ladyfingers and the remaining mascarpone mixture. Cover and refrigerate for at least 4 hours or overnight. Before serving, dust the top with cocoa powder.")
        }
        
        // Add Drinks
        if let drinkCategory = foodDataManager.getAllCategories().first(where: {$0.name == "Drinks"}) {
            foodDataManager.addItem(name: "Mojito", category: drinkCategory, description: "Refreshing cocktail made with rum, mint, lime juice, sugar, and soda water.", summary: "In a glass, muddle mint leaves, lime wedges, and sugar together to release the flavors. Add rum and stir to combine. Fill the glass with ice cubes, then top with club soda. Stir gently to mix everything together. Garnish with a sprig of mint and a lime wedge if desired.")
            foodDataManager.addItem(name: "Margarita", category: drinkCategory, description: "Classic cocktail made with tequila, triple sec, and lime juice, served with a salted rim.", summary: "Rub the rim of a glass with a lime wedge, then dip the rim into salt to coat it. Fill the glass with ice cubes. In a shaker, combine tequila, triple sec, and lime juice with ice. Shake well, then strain the mixture into the prepared glass. Garnish with a lime wedge.")
            foodDataManager.addItem(name: "Old Fashioned", category: drinkCategory, description: "Bourbon-based cocktail made with sugar, bitters, and a twist of citrus peel.", summary: "In a glass, dissolve sugar with a splash of water. Add bourbon and bitters, then fill the glass with ice cubes. Stir gently to mix everything together. Garnish with a twist of citrus peel.")
        }
        
        // Food Ingredients
        
        // Brushetta
        foodDataManager.addIngredients(ingredientName: "French Baguette", measurement: "4 slices")
        foodDataManager.addIngredients(ingredientName: "diced", measurement: "2 tomatoes")
        foodDataManager.addIngredients(ingredientName: "garlic (minced)", measurement: "2 cloves")
        foodDataManager.addIngredients(ingredientName: "fresh basil leaves (chopped)", measurement: "1/4 cup")
        foodDataManager.addIngredients(ingredientName: "olive oil", measurement: "2 tbsp")
        
        if let bruschetta = foodDataManager.getAllItems().first(where: { $0.name == "Bruschetta" }) {
            foodDataManager.addRecipe(foodItem: bruschetta, ingredients: foodDataManager.getAllIngredients())
        }
        
        
//        // Brushetta
//        foodDataManager.addIngredients(ingredientName: "(Bruschetta) French Baguette", measurement: "4 slices")
//        foodDataManager.addIngredients(ingredientName: "(Bruschetta) diced", measurement: "2 tomatoes")
//        foodDataManager.addIngredients(ingredientName: "(Bruschetta) garlic (minced)", measurement: "2 cloves")
//        foodDataManager.addIngredients(ingredientName: "(Bruschetta) fresh basil leaves (chopped)", measurement: "1/4 cup")
//        foodDataManager.addIngredients(ingredientName: "(Bruschetta) olive oil", measurement: "2 tbsp")
//
//        // Food Recipes
//
//        if let bruschetta = foodDataManager.getAllItems().first(where: { $0.name == "Bruschetta" }) {
//            let brushettaIng = foodDataManager.getAllIngredients().filter { $0.ingredientName.contains("(Bruschetta)") }
//
//            var brushettaRecipe = [FoodIngredients]()
//            brushettaIng.forEach { ingredient in
//                if let range = ingredient.ingredientName.range(of: ")") {
//                    let ingredientName = ingredient.ingredientName[range.upperBound...]
//                    ingredient.ingredientName = ingredientName
//                }
//
//            }
//
//
//            foodDataManager.addRecipe(foodItem: bruschetta, ingredients: foodDataManager.getAllIngredients())
//        }
        
        
        
        
        
        
        // Add Descriptions
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
        //        }
        
    }
    
}
