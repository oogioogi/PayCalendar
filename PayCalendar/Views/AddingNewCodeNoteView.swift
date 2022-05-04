//
//  AddingNewCodeNoteView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/03.
//

import SwiftUI

struct AddingNewCodeNoteView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    var selectMonthNotes: [NoteEntity]
    
    @Binding var isAddingNewCodeNoteView: Bool
    @Binding var indexDate: Date //리스트 데이트
    
    @State private var daycode: Code = .none
    @State private var howDoWork: HowWork = .weekday // 평일
    @State private var vacation: Leave = .none
    
    var body: some View {
        VStack {
            HStack {
                Text("New Code Add")
                    .font(.system(.title, design: .rounded)).fontWeight(.heavy)
                Spacer()
                Button {
                    self.isAddingNewCodeNoteView = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(.title, design: .default))
                }
            }
            
            // selectedNotes 구성중 튿정일이 같은 하는 저장된요소를 찾아서 note에 저장
            if let note = selectMonthNotes.first(where: { $0.selectedDay == indexDate.formattedInt }) {
                codeScreen(code: note.wrappedCode)
                howworkScreen(howwork: note.wrappedHowwork)
                vacationScreen(vacation: vacation)
            }else {
                codeScreen(code: daycode)
                howworkScreen(howwork: howDoWork)
                vacationScreen(vacation: vacation)
            }
            
            Circle()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.purple)
                .overlay(
                    Text("Save").font(.system(size: 16, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                )
                .onTapGesture {
                    if let editNote = selectMonthNotes.first(where: { $0.selectedDay == indexDate.formattedInt }) {
                        //편집 저장
                        viewContext.delete(editNote)
                        save()
                        self.isAddingNewCodeNoteView = false
                    }else {
                        // 신규 저장
                        save()
                        self.isAddingNewCodeNoteView = false
                    }
                }
        }
    }
    
    // - Save -
    private func save() {
        let newNote = NoteEntity(context: viewContext)
        newNote.id = UUID()
        newNote.selectedDate = indexDate
        newNote.selectedDay = indexDate.formattedInt
        newNote.selectedMonth = indexDate.formattedMonth
        newNote.wrappedCode = daycode
        newNote.wrappedHowwork = howDoWork
        newNote.wrappedLeave = vacation
        
        do {
            try viewContext.save()
        }catch {
            print("Failed to save the record...")
            print(error.localizedDescription)
        }
    }
    
    // - Edit -
//    private func edit(editor: NoteEntity) {
//        viewContext.delete(editor)
//
//        let newNote = NoteEntity(context: viewContext)
//        newNote.id = UUID()
//        newNote.selectedDate = Date()
//        newNote.selectedDay = indexDate.formattedInt
//        newNote.selectedMonth = indexDate.formattedMonth
//        newNote.wrappedCode = daycode
//        newNote.wrappedHowwork = howDoWork
//        newNote.wrappedLeave = vacation
//
//        do {
//            try viewContext.save()
//            self.isAddingNewCodeNoteView = false
//        }catch {
//            print("Failed to save the record...")
//            print(error.localizedDescription)
//        }
//    }
    
    // -- View Builser --
    @ViewBuilder
    private func codeScreen(code: Code) -> some View {
        VStack {
            Text("코드")
                .font(.system(size: 15)).fontWeight(.bold)
            Picker("DayCode", selection: $daycode) {
                ForEach(Code.allCases) { item in
                    Text(item.rawValue)
                }
            }.pickerStyle(.segmented)
        }
        .onAppear {
            self.daycode = code
        }
    }
    
    @ViewBuilder
    private func howworkScreen(howwork: HowWork) -> some View {
        VStack {
            Text("근무 환경 시간")
                .font(.system(size: 15)).fontWeight(.bold)
            Picker("Day Overtime", selection: $howDoWork) {
                ForEach(HowWork.allCases) { item in
                    Text(item.rawValue)
                }
            }.pickerStyle(.segmented)
        }
        .onAppear {
            switch indexDate.formattedWeekDay {
            case "토요일","일요일" :
                self.howDoWork = HowWork.dayoff
            default:
                self.howDoWork = howwork
            }
        }
    }
    
    @ViewBuilder
    private func vacationScreen(vacation: Leave) -> some View {
        
        VStack {
            Text("휴가")
                .font(.system(size: 15)).fontWeight(.bold)
            Picker("Vacation", selection: $vacation) {
                ForEach(Leave.allCases) { item in
                    Text(item.rawValue)
                }
            }.pickerStyle(.segmented)
        }
        .onAppear {
            self.vacation = vacation
        }
    }
}

struct AddingNewCodeNoteView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        //AddingNewCodeNoteView(noteResults: PersistenceController.preview.container.viewContext, isAddingNewCodeNoteView: .constant(false), indexDate: .constant(Date()))
    }
}
