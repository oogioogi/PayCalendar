//
//  CalendarModeView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/09.
//

import SwiftUI

struct CalendarModeView: View {
    
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @ObservedObject var monthlyPayDetailViewModel: MonthlyPayDetailViewModel
    
    var selectedMonthNotes: [NoteEntity]
    
    init(selectedMonthNotes: [NoteEntity]) {
        self.selectedMonthNotes = selectedMonthNotes
        self.monthlyPayDetailViewModel = MonthlyPayDetailViewModel(notes: selectedMonthNotes)
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    var weekdays: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    TextWithBadge(year: calendarViewModel.selectedYear, month: calendarViewModel.selectedOnlyMonth)
                    Spacer()
                    //ArrowView(monthCount: $calendarViewModel.monthCount)
                }
                
                Divider()
                    .background(Color.primary)
                // 요일 타이틀
                LazyVGrid(columns: columns) {
                    ForEach(weekdays, id: \.self) { day in
                        switch day {
                        case "Sun":
                            Text(day)
                                .foregroundColor(.red)
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.heavy)
                        case "Sat":
                            Text(day)
                                .foregroundColor(.blue)
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.heavy)
                        default:
                            Text(day)
                                .foregroundColor(.primary)
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.bold)
                        }
                        
                    }
                }
                // 달력
                LazyVGrid(columns: columns) {
                    // 첫요일 지정후 빈칸 넣음
                    loopView(index: calendarViewModel.getWeekDay)
                    ForEach(calendarViewModel.getCurrentMonth().getAllDate(), id:\.self) { indexDate in
                        if let monthNote = selectedMonthNotes.first(where: { $0.selectedDay == indexDate.formattedInt }) {
                            CalendarDay(monthNote: monthNote, selectedDate: indexDate)
                        }else {
                            CalendarDay(selectedDate: indexDate)
                        }
                        
                    }
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary, lineWidth: 2)
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .overlay(
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 3) {
                                Group {
                                    Text("연장 근무:  \(String(monthlyPayDetailViewModel.daysOverTime)) 시간")
                                    Text("휴일/휴무 연장 근무:  \(String(monthlyPayDetailViewModel.dayoffsOverTime)) 시간")
                                    Text("휴일 근무 합계:  \(String(monthlyPayDetailViewModel.countDayoffs)) 시간")
                                    Text("휴무 근무 합계:  \(String(monthlyPayDetailViewModel.countDaycloses)) 시간")
                                    Text("야간 근무 합계:  \(String(monthlyPayDetailViewModel.countNights)) 시간")
                                    Text("야간 교대 일수:  \(monthlyPayDetailViewModel.countNightShiftDays) 일")
                                }
                                .font(.subheadline)
                            }
                            .padding(.horizontal, 15)
                            Spacer()
                        }
                        
                    )
                
                Spacer()
            }
            .padding()
        }
        

    }
    
    @ViewBuilder
    func loopView(index: Int) -> some View {
        ForEach(1..<index, id: \.self) { i in
            Text("")
        }
        EmptyView()
    }
}

struct CalendarModeView_Previews: PreviewProvider {
    
    @StateObject static var calendarViewModel = CalendarViewModel()
    
    static var previews: some View {
        
        CalendarModeView(selectedMonthNotes: [])
            .environmentObject(calendarViewModel)
            .preferredColorScheme(.dark)
        
//        CalendarModeView(selectedMonthNotes: [])
//            .preferredColorScheme(.light)
    }
}
