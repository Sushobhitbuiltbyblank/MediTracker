//
//  LocalDataProvider.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 29/06/21.
//

import Foundation

class LocalDataProvider {
    
    static var shared: LocalDataProvider = {
        return LocalDataProvider()
    }()
    
    private init() {}
    
    func saveMedicalRecord(score:Int,currentTime:String,date:Date) {
        guard let recordEntity = CoreDataManager.shared.get(entity: .MediRecordData) else {
            print("Entity not Found")
            return
        }
        let record = MediRecordData(entity: recordEntity, insertInto: CoreDataManager.shared.managedObjectContext)
        record.recordDate = date
        record.score = Int32(score)
        record.timing = currentTime
        CoreDataManager.shared.saveContext()
    }
    
    func getHistoryAllRecord() -> [MediRecordData] {
        guard let records = CoreDataManager.shared.getAllObject(entity: .MediRecordData) as? [MediRecordData] else {
            return []
        }
        return records
    }
    
    func getHistory(byDate:Date) -> [MediRecordData]? {
        let calendar = Calendar.current
        let dateFrom = calendar.startOfDay(for: byDate) // eg. 2016-10-10 00:00:00
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom) ?? Date()
        let request = CoreDataManager.shared.getRequestForEntityName(entity: .MediRecordData)
        request.predicate = NSPredicate(format: "%K < %@ && %K > %@" ,#keyPath(MediRecordData.recordDate), dateTo as CVarArg,#keyPath(MediRecordData.recordDate),dateFrom as CVarArg)
        do {
            let results = try CoreDataManager.shared.managedObjectContext.fetch(request)
            if let detail = results as? [MediRecordData] {
                return detail
            } else {
                return nil
            }
        } catch let error {
            print("Operation error: \(error)")
            return nil
        }
    }
}
