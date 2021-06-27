//
//  AppCoordinator.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//
import UIKit

enum RootState {
    case todayRecord
}

final class AppCoordinator: BaseCoordinator {

    let navigationController = UINavigationController()
    let window               : UIWindow

    init(window: UIWindow) {
        self.window = window
        
        super.init()
    }

    override func start() {
        navigationController.isNavigationBarHidden = true
        window.rootViewController                  = navigationController
        
        // load the intial coordinator.
        let coordinator = initCoordinator(for: .todayRecord)
        coordinator.start()
        store(coordinator: coordinator)
        window.makeKeyAndVisible()
    }
    
    private func initCoordinator(for state: RootState) -> BaseCoordinator {
        let coordinator: BaseCoordinator
        
        switch state {
        case .todayRecord:
            coordinator = TodayRecordCoordinator(navigationController: navigationController)
        break
        }
    
        return coordinator
    }
}
