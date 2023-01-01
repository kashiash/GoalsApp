//
//  DateUtils.swift
//  GoalsApp
//
//  Created by DevTechie on 10/1/21.
//

import Foundation

extension Date {
    func toRelativeDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
}
