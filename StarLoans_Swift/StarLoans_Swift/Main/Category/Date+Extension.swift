//
//  Date+Extension.swift
//  BSBDJ
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 incich. All rights reserved.
//

import UIKit

extension Date {

    /// 时间差
    ///
    /// - Parameter fromDate: 起始时间
    /// - Returns: 对象
    public func daltaFrom(_ fromDate: Date) -> DateComponents {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: fromDate, to: self)
    }

    /// 是否是同一年
    ///
    /// - Returns: ture or false
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        let currendarYear = calendar.component(.year, from: Date())
        let selfYear =  calendar.component(.year, from: self)
        return currendarYear == selfYear
    }

    /// 是否是今天的时间
    ///
    /// - Returns: Bool
//    public func isToday() -> Bool{
//
//        let currentTime = Date().timeIntervalSince1970
//
//        let selfTime = self.timeIntervalSince1970
//
//        return (currentTime - selfTime) <= (24 * 60 * 60)
//    }
//
    public func isToday() -> Bool{
        return Calendar.current.isDateInToday(self)
    }
    

    /// 是否是昨天的时间
    ///
    /// - Returns: Bool
    public func isYesterday() -> Bool {

//        let currentTime = Date().timeIntervalSince1970
//
//        let selfTime = self.timeIntervalSince1970
//
//        return (currentTime - selfTime) > (24 * 60 * 60)
        return Calendar.current.isDateInYesterday(self)
    }

    
    /// 是否是明天
    ///
    /// - Returns: Bool
    public func isTomorrow() -> Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    
    /// 返回这个礼拜日期
    ///
    /// - Returns: String
    public func dateString(with dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        if Calendar.current.isDateInToday(self) {
            return "今天"
        }else if Calendar.current.isDateInYesterday(self) {
            return "昨天"
        }else if Calendar.current.isDateInTomorrow(self) {
            return "明天"
        }else {
            return formatter.string(from: self)
        }
    }
}

extension DateFormatter {
    public func getDateToYMD(with time: TimeInterval) -> String{
        self.dateFormat = "yyyy-MM-dd"
        return string(from: Date(timeIntervalSince1970: time))
    }
}
