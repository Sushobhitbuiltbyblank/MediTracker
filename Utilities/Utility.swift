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

