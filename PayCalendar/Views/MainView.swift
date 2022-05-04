//
//  MainView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: NoteEntity.entity(), sortDescriptors: [], animation: .default)
    var noteResults: FetchedResults<NoteEntity>
    
    @State var monthCount = 0
    @State var isAddingNewCodeNoteView: Bool = false
    @State var isMonthlyPayDetailView: Bool = false
    @State var indexDate: Date = Date()
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text("Hourly Pay Note")
                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                .padding(.horizontal, 5)
            }
            
            // 날짜 년도.월. 이동 버턴 애니메이션 효과 추가
            // *** 탭 제스쳐 좌우 이동으로도 가능 하게 끔 한다
            HStack {
                TextWithBadge(year: self.selectedYear, month: self.selectedOnlyMonth)
                Spacer()
                HStack {
                    Image(systemName: "arrowshape.turn.up.left.circle.fill")
                        .onTapGesture {
                            withAnimation {
                                self.monthCount -= 1
                            }
                        }
                    Image(systemName: "stop.circle.fill")
                        .onTapGesture {
                            withAnimation {
                                self.monthCount = 0
                            }
                        }
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .onTapGesture {
                            withAnimation {
                                self.monthCount += 1
                            }
                        }
                }.font(.title).foregroundColor(.purple)
            }
            
            HStack {
                LeaveDetailView(notes: selectedYearNotes)
                Spacer()
                Image(systemName: "dollarsign.circle.fill")
                    .font(.system(.largeTitle, design: .default))
                    .foregroundColor(.mint)
                    .onTapGesture {
                        self.isMonthlyPayDetailView.toggle()
                    }
            }
            
            List {
                // 선택한 달로 부터 일수를 구함
                ForEach(getCurrentMonth().getAllDate(), id:\.self) { indexDate in
                    if let monthNote = selectedMonthNotes.first(where: { $0.selectedDay == indexDate.formattedInt }) {
                        SelectedDateNoteView(monthNote: monthNote, selectedDate: indexDate)
                            .contextMenu {
                                Button {
                                    delete(index: indexDate)
                                } label: {
                                    HStack {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }

                                Button {
                                    self.isAddingNewCodeNoteView = true
                                    self.indexDate = indexDate
                                } label: {
                                    HStack {
                                        Text("Edit")
                                        Image(systemName: "square.and.pencil")
                                    }
                               }
                            }
                    }else {
                        SelectedDateNoteView(selectedDate: indexDate)
                            .onTapGesture {
                                isAddingNewCodeNoteView = true
                                self.indexDate = indexDate
                            }
                    }
                }
            }
            .listStyle(.plain)
            //새로운 코드 입력
            if isAddingNewCodeNoteView {
                AddingNewCodeNoteView(selectMonthNotes: selectedMonthNotes,
                                      isAddingNewCodeNoteView: $isAddingNewCodeNoteView,
                                      indexDate: $indexDate)
            }
        }
        .padding(.horizontal, 10)
        .sheet(isPresented: $isMonthlyPayDetailView, content: { MonthlyPayDetailView(notes: selectedMonthNotes) })
    }
    
    // *** delete func -> ViewModel
            public func delete(index: Date) {
                if let note = noteResults.first(where: {$0.selectedDay == index.formattedInt }) {
                    self.viewContext.delete(note)
                    
                    do {
                        try viewContext.save()
                    }catch {
                        print("Failed to save the record...")
                        print(error.localizedDescription)
                    }
                }
            }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
