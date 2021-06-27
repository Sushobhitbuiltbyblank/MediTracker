//
//  Coordinator.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators : [Coordinator] { get set }

    func start()
}

extension Coordinator {
    
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
}
