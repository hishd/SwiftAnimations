//
//  RootCoordinator.swift
//  SwiftAnimations
//
//  Created by Hishara Dilshan on 2024-06-26.
//

import Foundation
import UIKit

class RootCoordinator: NSObject ,Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = RootViewModel()
        let viewController = RootViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension RootCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let sourceViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(sourceViewController) {
            return
        }
        
        if let viewController = sourceViewController as? RootViewController {
            childDidFinish(viewController.coordinator)
        }
    }
}
