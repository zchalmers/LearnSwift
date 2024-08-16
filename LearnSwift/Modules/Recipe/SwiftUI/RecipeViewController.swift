//
//  RecipeViewController.swift
//  LearnSwift
//
//  Created by Zach on 7/31/24.
//

import Foundation
import UIKit
import SwiftUI

protocol FoodItemRecipeView: AnyObject {
    func updateView()
}

class RecipeViewController: UIViewController, FoodItemRecipeView {
    
    var delegate: RecipeViewDelegate!
    var dataSource: RecipeViewDataSource!
    fileprivate var recipeView: RecipeView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor(named: "Primary Background")
        delegate.viewDidLoad()
        self.navigationItem.title = dataSource.foodItem.name
    }
    
    func updateView(){
        loadRecipeView()
    }
    
    func loadRecipeView(){
        guard let dataSource = dataSource else {
            return
        }
        
        recipeView = RecipeView(model: dataSource.viewModel)
        let contentViewHC = UIHostingController(rootView: recipeView)
        addChild(contentViewHC)
        view.addSubview(contentViewHC.view)
        contentViewHC.didMove(toParent: self)
        contentViewHC.view.frame = .init(x: 0, y: 0, width: 300, height: 200)
        setupRecipeViewConstraints(recipeView: contentViewHC.view)
    }
    
    fileprivate func setupRecipeViewConstraints(recipeView: UIView) {
        recipeView.translatesAutoresizingMaskIntoConstraints = false
        recipeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        recipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        recipeView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        recipeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
