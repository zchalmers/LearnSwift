//
//  SwiftUIView.swift
//  LearnSwift
//
//  Created by Zach on 7/10/24.
//

import SwiftUI

struct RecipeView: View {
    var model: FoodRecipeViewModel

    init(model: FoodRecipeViewModel) {
        self.model = model
    }
    
    var body: some View {
        if let recipe = model.foodRecipe {
            VStack(spacing: 0) {
                RecipeViewHeader(recipeName: recipe.foodItem.name)
                
                List {
                    Section(header: SectionHeader(title: "Ingredients")) {
                        ForEach(recipe.foodIngredients) { ingredient in
                            RecipeRowView(ingredient: ingredient)
                        }
                    }
                    .listRowSeparator(.automatic)
                    
                    Section(header: SectionHeader(title: "Steps")) {
                        SummaryRowView(summary: recipe.foodItem.summary)
                    }
                }
                .listStyle(.grouped)
//                .padding(.top, -20)
//                .border(Color.red)
                .onAppear {
                    UICollectionView.appearance().backgroundColor = UIColor(Color("Primary Background"))
                    UICollectionView.appearance().contentInset.top = -15
                }
                
                
            }
            
        }
    }
}

struct SectionHeader: View {
    var title: String
    var titlePadding: EdgeInsets = EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 0)
    
    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                Text(title)
                    .frame(maxWidth: .infinity, maxHeight: 10, alignment: .leading)
                    .font(Font(UIFont.preferredFont(forTextStyle: .subheadline)))
                    .foregroundColor(Color("Secondary Label"))
                    .textCase(.none)
                    .padding(titlePadding)
                    .border(Color.red)
            }
            .background(Color("Primary Background"))
            
            Divider().frame(maxWidth: .infinity)
        }
        .padding(.horizontal, -20)
        .padding(.bottom, -10)
    }
}

struct RecipeViewHeader: View {
    var recipeName: String

    var body: some View {
        Image(recipeName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .clipped()
    }
}

struct RecipeRowView: View {
    var ingredient: FoodIngredients
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(ingredient.ingredientName)
                    .font(Font(UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)))
                    .foregroundColor(Color("Primary Label"))
                Spacer()
                Text(ingredient.measurement)
                    .font(Font(UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)))
                    .foregroundColor(Color("Primary Label"))
            }

            
        }
        .listRowBackground(Color("Secondary Grouped Background"))
    }
}

struct SummaryRowView: View {
    var summary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(summary)
                .font(Font(UIFont.preferredFont(forTextStyle: .subheadline)))
                .foregroundColor(Color("Secondary Label"))
        }
        .listRowBackground(Color("Secondary Grouped Background"))
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
