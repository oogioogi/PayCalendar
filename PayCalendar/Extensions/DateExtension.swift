//
//  DateExtension.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import Foundation

// Locale ko_kR
extension Date {
    // 연.월
    var formattedYearMonth: Int32 {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyyMM"
        
        return Int32(dateFormatter.string(from: self))!
    }
    // 연도
    var formattedYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: self)
    }
    // 월
    var formattedMonth: Int32 {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "MM"
        
        return Int32(dateFormatter.string(from: self))!
    }
    
    // 일
    var formattedDay: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "d"
        
        return Int(dateFormatter.string(from: self))!
    }
    
    // 요일
    var formattedWeekDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    // 2022_04_09
    var formattedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        
        return dateFormatter.string(from: self)
    }
    
    // 2022_04_09
    var formattedInt: Int32 {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyyMd"
        
        return Int32(dateFormatter.string(from: self))!
    }
    
    func getAllDate() -> [Date] {
        let calendar = Calendar.current
        // 시작일 얻음
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        //debugPrint(startDate)
        return range.compactMap{ day -> Date in
            //debugPrint(day)
            return calendar.date(bySetting: .day, value: day, of: startDate)!
        }
    }
    
}
