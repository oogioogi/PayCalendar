//
//  MainViewExtension.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import Foundation

extension MainView {
    
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
    
    // 선택한 년으로만 재배열 선언
    var selectedYearNotes: [NoteEntity] {
        return noteResults.filter({ $0.selectedDate.formattedYear == self.selectedYear })
    }
    
    // 선택한 월로만 재배열 선언
    var selectedMonthNotes: [NoteEntity] {
        return noteResults.filter({ $0.selectedDate.formattedYearMonth == self.selectedYearMonth })
    }
    
    // 선택한 월로만 재배열 선언 [x]
    var noteResultForMonth: NoteEntity? {
        return noteResults.first(where: { $0.selectedDate.formattedMonth == self.selectedYearMonth }) ?? nil
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.monthCount, to: Date()) else { return Date() }
        return currentMonth
    }
    
}
