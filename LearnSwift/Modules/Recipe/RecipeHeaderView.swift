//
//  RecipeHeaderView.swift
//  LearnSwift
//
//  Created by Zach on 5/15/24.
//

import Foundation
import UIKit

final class RecipeHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: RecipeHeaderView.self)
    
    var title: UILabel = UILabel()
    var measurement: UILabel = UILabel()
    var separator: UIView = UIView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(title)
        contentView.addSubview(measurement)
        contentView.addSubview(separator)
        
        contentView.backgroundColor = .white
        
        title.translatesAutoresizingMaskIntoConstraints = false
        measurement.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separator.backgroundColor = UIColor(named: "Separator") // Set separator color

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            measurement.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            measurement.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])


    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
