//
//  DateExtension.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [String] {
        var dates: [String] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date.getStringFormat())
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func getStringFormat (_ format: String = ApplicationConstants.dateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
