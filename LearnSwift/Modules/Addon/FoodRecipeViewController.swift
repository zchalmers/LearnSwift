//
//  DescriptionViewController.swift
//  LearnSwift
//
//  Created by Zach on 4/20/24.
//

import Foundation
import UIKit

protocol FoodRecipeView: AnyObject {
    func setupTableView()
    func updateView()
}

class FoodRecipeViewController: UIViewController, FoodRecipeView{
    
    var delegate: FoodRecipeDelegate!
    var dataSource: FoodRecipeDataSource!
    @IBOutlet weak var tableView: UITableView!
    
    
    class func instantiateViewController() -> FoodRecipeViewController {
        let bundle = Bundle(for: FoodRecipeViewController.self)
        let storyBoard = UIStoryboard(name: "FoodRecipeViewController", bundle: bundle)
        guard let foodRecipeVC = storyBoard.instantiateInitialViewController() as? FoodRecipeViewController else {
            fatalError("Unable to instantiate FoodRecipeViewController")
        }
        return foodRecipeVC
    }
    
    override func viewDidLoad(){
        super.viewDidLoad();
        setupTableView()
        delegate.viewDidLoad()
    }
    
    func updateView(){
        tableView.reloadData()
    }
    
    func setupTableView(){
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 25
        tableView.isEditing = false
    }
    
}

extension FoodRecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as? SectionHeaderView else {
            return nil
        }
        view.textLabel?.text = dataSource.foodItem.name
        view.textLabel?.font = .boldSystemFont(ofSize: 14.0)
        view.imageView.image = UIImage(systemName: "fork.knife")
        
        return view
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension FoodRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reuseIdentifier, for: indexPath) as? RecipeTableViewCell
        else {
            return UITableViewCell()
        }
        let ingredientName = dataSource.viewModel.foodRecipe?.foodIngredients[indexPath.row].ingredientName
        let measurement = dataSource.viewModel.foodRecipe?.foodIngredients[indexPath.row].measurement
        
        // Configure the cell’s contents.
        cell.label.text = ingredientName
        cell.quantity.text = measurement
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.viewModel.foodRecipe?.foodIngredients.count ?? 2
    }
}
