//
//  Date+Extension.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 29/06/21.
//

import Foundation

extension Date {
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
