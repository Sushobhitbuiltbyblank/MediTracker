//
//  TodayRecordViewModel.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import Foundation
import UIKit

class TodayRecordViewModel {
    
    func saveRecord(date:Date = Date()) {
        let timeInWord = getTimeInWord(date:date)
        let time = getCurrentTime(date)
        let score = self.scoreProvider(date)
        LocalDataProvider.shared.saveMedicalRecord(score: score, currentTime: "\(timeInWord) \(time)", date: date)
    }
    
    func haveCurrentRecord()-> Bool {
        guard let TodayRecords = LocalDataProvider.shared.getHistory(byDate: Date()) else { return false}
        let records =  TodayRecords.filter({ records in
            return getTimeInWord(date: records.recordDate ?? Date()) == getTimeInWord(date: Date())
        })
        if records.count > 0 {
            return true
        }
        return false
    }
    
    func scoreProvider(_ date:Date = Date()) -> Int {
        if let scoreBoard = DayTimeInterval(rawValue: getTimeInWord(date:date).lowercased()) {
            return scoreBoard.getScore()
        }
        return 0
    }
    
    func getCurrentTime(_ date:Date = Date(),_ formateSting:String = "hh:mm a")-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formateSting
        return formatter.string(from: date)
    }
    
    func getTodayScore()->Int {
        guard let records = LocalDataProvider.shared.getHistory(byDate: Date()) else { return 0 }
        var totalScore = 0
        for record in records {
            totalScore += Int(record.score)
        }
        return totalScore
    }
    
    func getScoreColor(score:Int) -> UIColor? {
        switch score {
        case 0...40 :
            return UIColor(named: "LowScore")
        case 41...70 :
            return UIColor(named: "MediumScore")
        default:
            return UIColor(named: "HighScore")
        }
    }
    
    func createNotificationFor(_ dayTime:DayTimeInterval) {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        let content = UNMutableNotificationContent()
        content.title       = dayTime.getContentTitle()
        content.body        = dayTime.getContentBody()
        dateComponents.hour = dayTime.getAlertTime()
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        // Create the request
        let request = UNNotificationRequest(identifier: dayTime.getNotificationIdentifier(),
                    content: content, trigger: trigger)
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
    }
    
    func checkForNotificationPermission() {
        // Request Notification Settings
            UNUserNotificationCenter.current().getNotificationSettings {[weak self] (notificationSettings) in
                switch notificationSettings.authorizationStatus {
                case .notDetermined:
                    self?.requestAuthorization(completionHandler: { (success) in
                        guard success else { return }

                        // Schedule Local Notification
                    })
                case .authorized:
                    self?.createNotificationFor(.morning)
                    self?.createNotificationFor(.afternoon)
                    self?.createNotificationFor(.evening)
                case .denied:
                    print("Application Not Allowed to Display Notifications")
                case .provisional:
                    break
                case .ephemeral:
                    break
                @unknown default:
                    print("Application Not Allowed to Display Notifications")
                }
            }
    }
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }

            completionHandler(success)
        }
    }
    
    func cancelNotification(_ identifier:String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers:[identifier])
    }
    

}

enum DayTimeInterval:String {
    case morning
    case afternoon
    case evening
    case night
    
    
    func getScore()-> Int{
        switch self {
        case .morning:
            return 30
        case .afternoon:
            return 30
        case .evening:
            return 40
        case .night:
            return 40
        }
    }
    
    func getAlertTime()->Int {
        switch self {
        case .morning:
            return 11
        case .afternoon:
            return 14
        default:
            return 20
        }
    }
    
    func getNotificationIdentifier() -> String {
        switch self {
        case .morning:
            return "Morning_Notification_Identifier"
        case .afternoon:
            return "Afternoon_Notification_Identifier"
        default:
            return "Evening_Notification_Identifier"
        }
    }
    
    func getContentTitle() -> String {
        switch self {
        case .morning:
            return "Reminder For Morning Medicine"
        case .afternoon:
            return "Reminder For Afternoon Medicine"
        default:
            return "Reminder For Evening Medicine"
        }
    }
    
    func getContentBody() -> String {
        switch self {
        case .morning:
            return "Please take your Morning Medicine and update the record here"
        case .afternoon:
            return "Please take your Afternoon Medicine and update the record here"
        default:
            return "Please take your Evening Medicine and update the record here"
        }
    }
}

