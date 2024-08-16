//
//  UIFont+extension.swift
//  LearnSwift
//
//  Created by Zach on 6/20/24.
//

import Foundation
import UIKit

extension UIFont {
    
    static var title1: UIFont {
        return UIFont.preferredFont(forTextStyle: .title1, weight: UIFont.Weight.black)
    }
    
    class func preferredFont(forTextStyle style: UIFont.TextStyle, weight: Weight = .regular, size: CGFloat? = nil) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let descriptor = preferredFont(forTextStyle: style).fontDescriptor
        let defaultSize = descriptor.pointSize
        let fontToScale = UIFont.systemFont(ofSize: size ?? defaultSize, weight: weight)
        return metrics.scaledFont(for: fontToScale)
    }
}
