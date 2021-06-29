//
//  Utility.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import Foundation

// Use this method to print statements when in debug mode
func debugLog(message: String) {
    #if DEBUG
    print("\n*******************\n\(message)\n*******************\n")
    #endif
}

func getTimeInWord(date:Date) -> String {
    let hour = Calendar.current.component(.hour, from: date)
    switch hour {
    case 6...12 :
        return "Morning"
    case 13..<17 :
        return "Afternoon"
    case 17..<22 :
        return "Evening"
    default:
        return "Evening"
    }
}
