//
//  MainViewExtension.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import Foundation

extension MainView {
    
    // 선택한 년으로만 재배열 선언
    var selectedYearNotes: [NoteEntity] {
        return noteResults.filter({ $0.selectedDate.formattedYear == calendarViewModel.selectedYear })
    }

    // 선택한 월로만 재배열 선언
    var selectedMonthNotes: [NoteEntity] {
        return noteResults.filter({ $0.selectedDate.formattedYearMonth == calendarViewModel.selectedYearMonth })
    }

    // 선택한 월로만 재배열 선언 [x]
    var noteResultForMonth: NoteEntity? {
        return noteResults.first(where: { $0.selectedDate.formattedMonth == calendarViewModel.selectedYearMonth }) ?? nil
    }
}

