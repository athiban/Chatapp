//
//  DateExtension.swift
//  Chatapp
//
//  Created by Athiban Ragunathan on 27/11/24.
//
import UIKit

extension DateFormatter {
    static let sharedFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        return df
    }()
}

extension Date {
    func asString(withFormat format : String, timeZone : TimeZone = .current) -> String {
        let dateFormatter = DateFormatter.sharedFormatter
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

