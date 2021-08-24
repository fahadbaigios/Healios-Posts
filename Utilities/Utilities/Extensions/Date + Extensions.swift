//
//  Date + Extensions.swift
//  Common
//
//  Created by Taimour Tanveer on 22/01/2019.
//  Copyright © 2019 Techtix co. All rights reserved.
//

import UIKit

public extension TimeZone {
    static let UTC = TimeZone(identifier: "UTC")!
}

public extension Date{
    
    /** Convenience static method on Date class to construct a Date object from a supplied String.
    
     - Important: The date must be provided using timezone "UTC"
    - Parameters:
      - dateString: The string defining the date
      - format: Format of the provided date. Optional. Default is "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    - Returns: Data object constructed from the supplied string and format. Returns nill if the provided string is not valid according to the provided format.
     */
    static func date(fromString dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        return date
    }
    /**
     Convenience method to get `String` representation of `Date` object according to the provided string format.
     
     - Parameter format: Format in which the string is expected. Optional. Default is "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
     - Returns: `String` representation of the `Date`
     */
    func string(format:String="yyyy-MM-dd'T'HH:mm:ss.SSSZ", timezone: TimeZone = TimeZone.UTC) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timezone
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        return dateFormatter.string(from: self)
    }
    
    /// Convenience method to convert difference of date from a specific date in terms of Difference String.
    ///
    /// - Parameter date: Date from which the time difference is required
    /// - Returns: String representing difference between the two dates
    func offsetFrom(date: Date) -> String {
        let unitFlags:Set<Calendar.Component> = [.year,.month ,.day, .hour, .minute, .second]
        let difference = Calendar.current.dateComponents(unitFlags, from: self,to:date)
        
        let minutes = "\(difference.minute!)m" + " "
        let hours = "\(difference.hour!)h" + " " + minutes
        let days = "\(difference.day!)d" + " " + hours
        let month = "\(difference.month!)M" + " " + days
        
        if difference.month! > 0  { return month}
        if difference.day!   > 0 { return days }
        if difference.hour!  > 0 { return hours }
        if difference.minute! > 0 { return minutes }
        return ""
    }
    
    /// Returns the number of Calender units intervals from another date.
    ///
    /// - Parameters:
    ///   - unit: The Calender unit for which number of intervals are required. E.g: Calender.Component.day or Calender.Component.minute
    ///   - fromDate: The date from which the interval is required
    /// - Returns: The number of unit intervals from the provided date
    func offsetBy(unit: Calendar.Component, fromDate:Date) -> Int{
        let unitFlags:Set<Calendar.Component> = [unit]
        let difference = Calendar.current.dateComponents(unitFlags, from: fromDate, to: self)
        
        var result:Int!
        switch unit {
        case .year:
            result = difference.year ?? 0
        case .month:
            result = difference.month ?? 0
        case .day:
            result = difference.day ?? 0
        case .hour:
            result = difference.hour ?? 0
        case .minute:
            result = difference.minute ?? 0
        case .second:
            result = difference.second ?? 0
        case .nanosecond:
            result = difference.second ?? 0
        default:
            result = 0
        }
        
        return result
    }
    
    /// Returns a date formatter string with UTC timezone
    var utcValue: String {
        let dateFormater = DateFormatter()
        dateFormater.calendar = Calendar.current
        dateFormater.timeZone = TimeZone(abbreviation: "UTC")
        let currentTimeString = dateFormater.string(from: self)
        return currentTimeString
    }
    
    /// Returns string for current time
    static var timeStamp: String {
        let date = Date().timeIntervalSince1970
        return "\(date)"
    }
    
    func comapreTime(date: Date) -> ComparisonResult {
        let currentSecs = secondsSinceBeginningOfDay(date: self)
        let otherSecs = secondsSinceBeginningOfDay(date: date)
        if currentSecs < otherSecs {
            return .orderedAscending
        }else if currentSecs > otherSecs {
            return .orderedDescending
        }else {
            return .orderedSame
        }
    }
    private func secondsSinceBeginningOfDay(date: Date) -> Int {
        let component = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hours = (component.hour ?? 0) * 3600
        let min = (component.minute ?? 0) * 60
        return hours + min
    }
}
extension Date{
    /// Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).isInFuture -> true
    ///
    public var isInFuture: Bool {
        return self > Date()
    }
    
    
    /// Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isInPast -> true
    ///
    public var isInPast: Bool {
        return self < Date()
    }
    
    /// Check if date is within today.
    ///
    ///     Date().isInToday -> true
    ///
    public var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    public func getDateFrom(dateStyle: DateStyle, timezone: TimeZone = .current) -> String {
        let dateFormate = DateFormatter()
        dateFormate.timeZone = timezone
        switch dateStyle {
        case .short:
            dateFormate.dateStyle = .short
        case .shortTime:
            dateFormate.timeStyle = .short
        case .dateWithMonthName:
            dateFormate.dateFormat = "dd MMM"
            return dateFormate.string(from: self)
        default:
            dateFormate.dateStyle = .full
        }
        let formattedDate = dateFormate.string(from: self)
        return formattedDate
    }
    
}
public enum DateStyle: Int {

    case short = 1// 11/23/20
    case shortTime = 2 // 3:30 Pm
    case dateWithMonthName =  3// 5 july

//    case medium = 2
//
//    case long = 3
//
//    case full = 4
    
}
