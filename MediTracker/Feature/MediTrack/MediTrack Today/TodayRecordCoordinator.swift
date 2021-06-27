//
//  TodayRecordCoordinator.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import Foundation
import UIKit

final class TodayRecordCoordinator : BaseCoordinator {
    
    enum Destination {
        case history
    }
   
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        
        super.init()
    }

    override func start() {
        let todayRecordVC       = TodayRecordVC.instantiate(from: .mediTrack)
        todayRecordVC.viewModel = TodayRecordViewModel()
        
        todayRecordVC.coordinatorCallback = { [weak self] destination in
            self?.navigate(to: destination)
        }
        navigationController?.pushViewController(todayRecordVC, animated: true)
    }
    
    private func navigate(to destination: Destination) {
//        switch  destination {
//        case .detail(let city):
//            let coordinator = AQIDetailCoordinator(navigationController: navigationController,
//                                                   city: city)
//            coordinator.start()
//            store(coordinator: coordinator)
//        }
    }
}

