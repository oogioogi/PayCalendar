//
//  CalendarDay.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/10.
//

import SwiftUI

struct CalendarDay: View {
    
    var monthNote: NoteEntity?
    var selectedDate: Date = Date()
    
    @State var isSaturday: Bool = false
    @State var isSunday: Bool = false
    
    var body: some View {
        VStack(spacing: 2) {
            displayDay(selectedDate: self.selectedDate)
                .frame(height: 80)
                .overlay (
                    VStack {
                        Text("\(selectedDate.formattedDay)")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                        Spacer()
  
                        if monthNote?.wrappedLeave.rawValue == "연차" || monthNote?.wrappedLeave.rawValue == "월차" {
                            Text(monthNote?.wrappedLeave.rawValue ?? "")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(.purple)
                                
                        }else {
                            Text(monthNote?.wrappedCode.rawValue ?? "")
                                .font(.system(.caption, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(.primary)
                                
                        }
                        
                    }
                        .frame(height: 60)
                )
        }
    }
    
    @ViewBuilder
    func displayDay(selectedDate: Date) -> some View {
        switch selectedDate.formattedWeekDay {
        case "토요일":
            RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1)
                //.foregroundColor(.blue)
                
        case "일요일":
            RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1)
                //.foregroundColor(.red)
            
        default :
            RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1)
                //.foregroundColor(.gray)
            
        }
    }
}

struct CalendarDay_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDay()
            .preferredColorScheme(.dark)
//        CalendarDay()
//            .preferredColorScheme(.light)
    }
}
