//
//  BaseVC.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    deinit {
        debugLog(message: "Deiniting view controller: \(self)")
    }
}
