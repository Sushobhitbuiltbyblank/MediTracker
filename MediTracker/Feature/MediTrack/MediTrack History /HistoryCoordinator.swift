//
//  HistoryCoordinator.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import Foundation
import UIKit

final class HistoryCoordinator:BaseCoordinator {
    
    enum Destination {
        case back
    }
   
    var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() {
        let vc =       HistoryVC.instantiate(from: .mediTrack)
        vc.viewModel = HistoryViewModel()
        vc.coordinatorCallback = { [weak self] destination in
            self?.navigate(to: destination)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigate(to destination:Destination) {
        switch destination {
        case .back:
            navigationController?.popViewController(animated: true)
        }
    }
    
}
