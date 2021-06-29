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
    @IBOutlet weak var historyBtn: UIButton!
    
    var viewModel:TodayRecordViewModel!
    var coordinatorCallback: ((TodayRecordCoordinator.Destination)-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
        self.viewModel.checkForNotificationPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViewData()
    }
    
    func setUpViews() {
        self.bottomBtn.layer.cornerRadius = self.bottomBtn.frame.height / 5
        self.bottomBtn.layer.masksToBounds = true
        self.historyBtn.layer.cornerRadius = self.historyBtn.frame.height / 5
        self.historyBtn.layer.masksToBounds = true
    }
    
    func updateViewData() {
        greetingL.text = "Good \(getTimeInWord(date: Date()))"
        let score = viewModel.getTodayScore()
        self.scoreL.text = "\(score)"
        self.scoreL.textColor = viewModel.getScoreColor(score: score)
    }

    @IBAction func onClickBottomBtn(_ sender: Any) {
        if !viewModel.haveCurrentRecord() {
            viewModel.saveRecord()
            updateViewData()
            if let dayTime = DayTimeInterval(rawValue: getTimeInWord(date: Date()).lowercased()) {
                self.viewModel.cancelNotification(dayTime.getNotificationIdentifier())
            }
        }
    }
    
    @IBAction func onClickHistoryBtn(_ sender: Any) {
        self.coordinatorCallback?(.history)
    }
    
}

