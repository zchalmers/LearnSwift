//
//  FoodItemViewController.swift
//  LearnSwift
//
//  Created by Zach on 4/8/24.
//

import UIKit

protocol FoodItemView: AnyObject {
    func setupTableView()
    func updateView()
    var isSearching: Bool { get set }
}

class FoodItemViewController: UIViewController, FoodItemView {
    
    var delegate: FoodItemDelegate!
    var dataSource: FoodItemDataSource!
    @IBOutlet weak var tableView: UITableView!
    
    var diffableDataSource: UITableViewDiffableDataSource<FoodItemSectionModel, FoodItemRowModel>?
    var searchController: UISearchController?
    var isSearching: Bool = false
    
    class func instantiateViewController() -> FoodItemViewController {
        let bundle = Bundle(for: FoodItemViewController.self)
        let storyboard = UIStoryboard(name: "FoodItemViewController", bundle: bundle)
        guard let foodItemVC = storyboard.instantiateInitialViewController() as? FoodItemViewController else {
            fatalError("Unable to instantiate FoodItemViewController")
        }
        return foodItemVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = dataSource.foodCategory.name
        setupTableView()
        setupSearchController()
        delegate.viewDidLoad()
    }
    
    func updateView() {
        updateSnapshot()
    }
    
    func setupTableView() {
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 30
        tableView.estimatedSectionFooterHeight = 25
        tableView.isEditing = false
        
        setupDiffableDatasource()
    }
    
    func setupDiffableDatasource() {
        diffableDataSource = UITableViewDiffableDataSource<FoodItemSectionModel, FoodItemRowModel>(tableView: self.tableView, cellProvider: {  tableView, indexPath, row in
            return row.getRowCell(tableView: tableView, indexPath: indexPath)
        })

        updateSnapshot()
    }

    func updateSnapshot(animated: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<FoodItemSectionModel, FoodItemRowModel>()

        dataSource.getSections()
            .forEach { section in
                snapshot.appendSections([section])
                snapshot.appendItems(section.rows)
            }

        diffableDataSource?.apply(snapshot, animatingDifferences: animated)
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = delegate as? UISearchResultsUpdating
        searchController?.searchBar.delegate = delegate as? UISearchBarDelegate

        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension FoodItemViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30.0
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as? SectionHeaderView else {
//            return nil
//        }
//        view.textLabel?.text = dataSource.foodCategory.name
//        view.textLabel?.textColor = UIColor(named: "Secondary Label")
//        view.textLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
//        view.imageView.image = UIImage(systemName: "fork.knife")
//
//        return view
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let diffableDataSource = diffableDataSource else { return }
        
        let sections = diffableDataSource.snapshot().sectionIdentifiers
        let row = sections[indexPath.section].rows[indexPath.row]
        delegate.didTap(row: row)
    }
    
}
