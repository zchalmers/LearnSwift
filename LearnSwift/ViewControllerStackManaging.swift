//
//  ViewControllerStackManaging.swift
//  LearnSwift
//
//  Created by Chalmers, Chris on 4/8/24.
//

import UIKit

public protocol ViewControllerStackManaging {

    func push(_ viewController: UIViewController, animated: Bool)
    func pop()
    func presentModaly(_ viewController: UIViewController, animated: Bool)
    func dismissModal()
    func getTopMostViewController() -> UINavigationController?
}

extension UINavigationController: ViewControllerStackManaging {
    
    public func getTopMostViewController() -> UINavigationController? {
        let scenes = UIApplication.shared.connectedScenes
        
        guard let windowScene = scenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return nil
        }
        
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        
        return topController as? UINavigationController
    }
    
    public func dismissModal() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    public func presentModaly(_ viewController: UIViewController, animated: Bool) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    public func push(_ viewController: UIViewController, animated: Bool) {
        self.pushViewController(viewController, animated: animated)
    }
    
    public func pop() {
        self.popViewController(animated: true)
    }
    
    //    public func presentPopover(_ viewController: UIViewController, from: UIBarButtonItem, animated: Bool = true) {
    //        let navController = UINavigationController(rootViewController: viewController)
    //        navController.modalPresentationStyle = .popover
    //        navController.popoverPresentationController?.barButtonItem = from
    //        navController.preferredContentSize = CGSize(width: 350, height: 300)
    //        present(navController, animated: animated)
    //    }
    
}
