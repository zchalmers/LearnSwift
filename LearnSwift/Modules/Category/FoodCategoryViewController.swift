//
//  ViewController.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import UIKit

protocol FoodCategoryView: AnyObject {
    func setupTableView()
    func setupNavigation()
    func updateView()
}

class FoodCategoryViewController: UIViewController, FoodCategoryView {
    
    var delegate: FoodCategoryDelegate!
    var dataSource: FoodCategoryDataSource!
    var filterButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var diffableDataSource: UITableViewDiffableDataSource<FoodCategorySectionModel, FoodCategoryRowModel>?
    
    class func instantiateViewController() -> FoodCategoryViewController {
        let bundle = Bundle(for: FoodCategoryViewController.self)
        let storyboard = UIStoryboard(name: "FoodCategoryViewController", bundle: bundle)
        guard let foodCategoryVC = storyboard.instantiateInitialViewController() as? FoodCategoryViewController else {
            fatalError("Unable to instantiate FoodCategoryViewController")
        }
        return foodCategoryVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Food Categories"
        
        setupTableView()
        setupNavigation()
        delegate.viewDidLoad()
    }
    
    func updateView() {
        updateSnapshot()
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 25
        tableView.isEditing = false
        
        setupDiffableDatasource()
    }
    
    func setupDiffableDatasource() {
        diffableDataSource = UITableViewDiffableDataSource<FoodCategorySectionModel, FoodCategoryRowModel>(tableView: self.tableView, cellProvider: {  tableView, indexPath, row in
            return row.getRowCell(tableView: tableView, indexPath: indexPath)
        })
        
        updateSnapshot()
    }
    
    func updateSnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<FoodCategorySectionModel, FoodCategoryRowModel>()
        
        dataSource.getSections()
            .forEach { section in
                snapshot.appendSections([section])
                snapshot.appendItems(section.rows)
            }
        
        diffableDataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func setupNavigation() {
        // Filter
        filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action:  #selector(tappedFilter))
        
        if let filterButton = filterButton {
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItem = filterButton
            }
        }
    }
    
    @objc
    func tappedFilter() {
        print("In tappedFilter()")
    }
    
}

extension FoodCategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let diffableDataSource = diffableDataSource else { return }
        
        let sections = diffableDataSource.snapshot().sectionIdentifiers
        let row = sections[indexPath.section].rows[indexPath.row]
        
        delegate.didTap(row: row)
    }
    
}

