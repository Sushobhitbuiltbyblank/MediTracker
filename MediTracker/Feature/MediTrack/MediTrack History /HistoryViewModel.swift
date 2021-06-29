//
//  HIstoryViewModel.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import Foundation

class HistoryViewModel {
    
    var historyRecords:[HistoryCellModel]?
    var refreshUI:(Bool)->Void = {_ in}
    
    func getHistory() {
        let records = LocalDataProvider.shared.getHistoryAllRecord()
        var dic:[String:[MediRecordData]] = [String:[MediRecordData]]()
        for record in records {
            guard let date = record.recordDate?.string(format: "d/M/yyyy") else {
                return
            }
            if dic[date] != nil {
                dic[date]?.append(record)
            } else {
                let arr = [record]
                dic[date] = arr
            }
        }
        self.historyRecords = [HistoryCellModel]()
        for (_,arr) in dic {
            var totalScore = 0
            var records = [String]()
            var date = Date()
            for record in arr {
                totalScore += Int(record.score)
                records.append(record.timing ?? "")
                date = record.recordDate ?? Date()
            }
            let cellModel = HistoryCellModel(records: records, date: date, score: totalScore)
            self.historyRecords?.append(cellModel)
        }
        self.historyRecords?.sort(by: { $0.date ?? Date() > $1.date ?? Date() })
        self.refreshUI(true)
    }
}


struct HistoryCellModel {
    var records:[String]?
    var date:Date?
    var score:Int
    
    var dateString: String {
        return date?.string(format: "d/M/yyyy") ?? ""
    }
}
