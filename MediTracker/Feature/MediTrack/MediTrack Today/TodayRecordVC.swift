//
//  ViewController.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import UIKit

class TodayRecordVC: BaseVC, Storyboarded {
    @IBOutlet weak var scoreL: UILabel!
    @IBOutlet weak var todayScoreL: UILabel!
    @IBOutlet weak var greetingL: UILabel!
    @IBOutlet weak var bottomBtn: UIButton!
    
    var viewModel:TodayRecordViewModel!
    var coordinatorCallback: ((TodayRecordCoordinator.Destination)-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }
    
    func setUpViews() {
        self.bottomBtn.layer.cornerRadius = self.bottomBtn.frame.height / 5
        self.bottomBtn.layer.masksToBounds = true
    }

    @IBAction func onClickBottomBtn(_ sender: Any) {
        
    }
    
}

