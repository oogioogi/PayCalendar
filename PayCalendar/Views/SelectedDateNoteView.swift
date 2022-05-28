//
//  SelectedDateNoteView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI

struct SelectedDateNoteView: View {
    
    var monthNote: NoteEntity?
    var selectedDate: Date = Date()

    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .bottom, spacing: 0) {
                    Text("\(selectedDate.formattedDay)")
                        .font(.system(.title, design: .rounded)).fontWeight(.heavy)
                        .foregroundColor(selectedDate.formattedInt == Date().formattedInt ? .yellow : .primary)
                        .underline(selectedDate.formattedInt == Date().formattedInt ? true : false, color: .yellow) // 밑줄 추가
                    Text(".day")
                        .font(.system(.caption, design: .rounded)).fontWeight(.bold)
                }
                weekEndColorPicking(weekend: selectedDate.formattedWeekDay)
            }
            HStack {
                Spacer()
                noteView(monthNote: monthNote)
            }.font(.system(size: 18, weight: .bold))
        }
    }
}

struct SelectedDateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedDateNoteView(monthNote: NoteEntity(context: PersistenceController.preview.container.viewContext))
            .previewLayout(.sizeThatFits)
    }
}


@ViewBuilder
private func weekEndColorPicking(weekend: String) -> some View {
    switch weekend {
    case "토요일":
        Text(weekend)
            .font(.system(.title2, design: .default))
            .fontWeight(.heavy)
            .foregroundColor(.blue)
    case "일요일":
        Text(weekend)
            .font(.system(.title2, design: .default))
            .fontWeight(.heavy)
            .foregroundColor(.red)
    default:
        Text(weekend)
            .foregroundColor(.primary)
    }
}

@ViewBuilder
private func noteView(monthNote: NoteEntity?) -> some View {
    if let monthNote = monthNote {
        if monthNote.wrappedCode.value > -1 {
            Group {
                HStack(alignment: .bottom, spacing: 20) {
                    // 주/야
                    switch (monthNote.wrappedCode) {
                    case .T,.N,.Y:
                        Image("moon").resizable().frame(width:40, height: 40)
                        // 근무 형태
                    default :
                        Image("sun").resizable().frame(width:40, height: 40)
                    }
                    
                    // 근무 형태
                    switch (monthNote.wrappedHowwork) {
                    case .weekday:
                        HowWork.weekday.image.resizable().frame(width:40, height: 40)
                    case .dayclosed:
                        HowWork.dayclosed.image.resizable().frame(width:40, height: 40)
                    case .dayoff :
                        HowWork.dayoff.image.resizable().frame(width:40, height: 40)
                    }
                    
                    Text(monthNote.wrappedCode.rawValue)
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .foregroundColor(.green) // 근무 코드
                }
                
                
            }
            .opacity(monthNote.wrappedLeave.select < 1 ? 1.0 : 0.0) //연치/월차 이면 안보임
            
            if monthNote.wrappedLeave.select > 0 {
                HStack {
                    Image("leave")
                        .resizable()
                        .frame(width:40, height: 40)
                    Text(monthNote.wrappedLeave.rawValue) // 연차/월차
                        .opacity(monthNote.wrappedLeave.select < 1 ? 0.0 : 1.0)
                        .foregroundColor(monthNote.wrappedLeave.select > 1 ? .blue : .pink)
                }
            }
        }
    }
}
