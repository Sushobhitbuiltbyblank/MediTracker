//
//  MediTrackerTests.swift
//  MediTrackerTests
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import XCTest
@testable import MediTracker

 //        let string = "27/06/2021 09:20 AM"
 //        // Create Date Formatter
 //        let dateFormatter = DateFormatter()
 //        // Set Date Format
 //        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
 //        // Convert String to Date
 //        let date1  = dateFormatter.date(from: string) ?? Date()
 //        viewModel.addDummyRecord(date: date1)
 //
 //        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
 //        viewModel.addDummyRecord(date: date)

class MediTrackerTests: XCTestCase {
    var todayVM : TodayRecordViewModel?

    override func setUpWithError() throws {
        todayVM = TodayRecordViewModel()
    }

    override func tearDownWithError() throws {
        todayVM = nil
    }
    
    func testEntryDate() {
        let string = "28/06/2021 7:20 am"
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "dd/MM/yy H:mm aa"
        // Convert String to Date
        let date1  = dateFormatter.date(from: string) ?? Date()
        todayVM?.saveRecord(date: date1)
        
        XCTAssert(((todayVM?.haveCurrentRecord()) != nil))
    }
    
    func testEnterOneDayDate() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        todayVM?.saveRecord(date: date)
        
        XCTAssert(((todayVM?.haveCurrentRecord()) != nil))
    }
    

}
