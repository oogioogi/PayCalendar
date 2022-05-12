//
//  MonthlyPayDetailView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/04.
//

import SwiftUI

struct MonthlyPayDetailView: View {
    
    @ObservedObject var monthlyPayDetailViewModel: MonthlyPayDetailViewModel
    var notes: [NoteEntity]
    
    init(notes: [NoteEntity]) {
        self.notes = notes
        self.monthlyPayDetailViewModel = MonthlyPayDetailViewModel(notes: notes)
    }
    
    var body: some View {
        
        List {
            Section {
                detailPayRows(title: "연장 수당", content: monthlyPayDetailViewModel.overTimePay)
                detailPayRows(title: "휴무일 연장 수당", content: monthlyPayDetailViewModel.dayoffOverTimePay)
                detailPayRows(title: "휴일 수당", content: monthlyPayDetailViewModel.dayoffPay)
                detailPayRows(title: "휴무 수당", content: monthlyPayDetailViewModel.dayClosedPay)
                detailPayRows(title: "야간 수당", content: monthlyPayDetailViewModel.nightPay)
                detailPayRows(title: "야간 교대 수당", content: monthlyPayDetailViewModel.nightShiftDaysPay)
                    
            } header: {
                Text("수당")
                    .font(.system(.title2, design: .default))
                    .fontWeight(.heavy)
            }
                
            Section {
                detailHourRows(title: "평일 연장", content: monthlyPayDetailViewModel.daysOverTime)
                detailHourRows(title: "휴일 연장", content: monthlyPayDetailViewModel.dayoffsOverTime)
                detailHourRows(title: "휴일 근무", content: monthlyPayDetailViewModel.countDayoffs)
                detailHourRows(title: "휴무 근무", content: monthlyPayDetailViewModel.countDaycloses)
                detailHourRows(title: "야간 근무", content: monthlyPayDetailViewModel.countNights)
                    
            } header: {
                Text("시간")
                    .font(.system(.title2, design: .default))
                    .fontWeight(.heavy)
            }
                
            Section {
                detailHourRows(title: "사용 일수", content: monthlyPayDetailViewModel.countAnnuals)
            } header: {
                Text("월차")
                    .font(.system(.title2, design: .default))
                    .fontWeight(.heavy)
            }
        }
        .listStyle(InsetGroupedListStyle())
        
    }
    
    @ViewBuilder
    func detailPayRows(title: String, content: () -> Double) -> some View {
        HStack {
            Text(title)
                .font(.system(.body, design: .default)).fontWeight(.heavy)
            Spacer()
            Text(content().formatted(.currency(code: "krw")))
                .font(.system(size: 20, weight: .bold, design: .rounded))
        }
    }
    
    @ViewBuilder
    func detailHourRows(title: String, content: Double) -> some View {
        HStack(alignment: .bottom) {
            Text(title).font(.system(.body, design: .default)).fontWeight(.heavy)
            Spacer()
            Text(String(content)).font(.system(size: 20, weight: .bold, design: .rounded))
            Text("hour").font(.system(size: 15, weight: .bold, design: .rounded))
        }
    }
    
}

struct MonthlyPayDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyPayDetailView(notes: [])
    }
}
