//
//  BaseCoordinator.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("The child coordinators must implement `start`.")
    }
    
    deinit {
        debugLog(message: "Deiniting Coordinator: \(self)")
    }
}
