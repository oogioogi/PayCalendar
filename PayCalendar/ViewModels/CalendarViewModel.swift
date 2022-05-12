//
//  CalendarViewModel.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/09.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    
    @Published var monthCount = 0
    
    init() {  }

    // 선택 년을 구함
    var selectedYear: String {
        return getCurrentMonth().formattedYear
    }
    
    // 선택 월을 구함
    var selectedOnlyMonth: Int32 {
        return getCurrentMonth().formattedMonth
    }
    
    // 선택 년.월을 구함
    var selectedYearMonth: Int32 {
        return getCurrentMonth().formattedYearMonth
    }
    
    var getWeekDay: Int {
        let calendar = Calendar.current
        let allDays = getCurrentMonth().getAllDate()
        let index = calendar.component(.weekday, from: allDays.first ?? Date())
        return index
    }
//    var shiftToDay: [Date] {
//        
//        //getCurrentMonth().getAllDate()
//    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.monthCount, to: Date()) else { return Date() }
        return currentMonth
    }
}
