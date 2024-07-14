//
//  RecipeTableHeaderView.swift
//  LearnSwift
//
//  Created by Chalmers on 7/11/24.
//

import Foundation
import UIKit

final class RecipeTableHeaderView: UIView {
    @IBOutlet var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
