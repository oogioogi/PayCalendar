//
//  MainView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    
    @FetchRequest(entity: NoteEntity.entity(), sortDescriptors: [], animation: .default)
    var noteResults: FetchedResults<NoteEntity>

    @State var isAddingNewCodeNoteView: Bool = false
    @State var isMonthlyPayDetailView: Bool = false
    @State var isCalendarModeView: Bool = false
    @State var isInfoSetting: Bool = false
    @State var isLeftArrow: Bool = false
    @State var indexDate: Date = Date()
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Text("Pay Calendar")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                
                // 날짜 년도.월. 이동 버턴 애니메이션 효과 추가
                // *** 탭 제스쳐 좌우 이동으로도 가능 하게 끔 한다
                HStack {
                    TextWithBadge(year: calendarViewModel.selectedYear, month: calendarViewModel.selectedOnlyMonth)
                    Spacer()
                    ArrowView(monthCount: $calendarViewModel.monthCount)
                }
                
                Divider()
                    .background(Color.pink)
                // 연차 사용 갯수. 슬라이드 뷰
                HStack {
                    LeaveDetailView(notes: selectedYearNotes)
                    SlideButtons(isMonthlyPayDetailView: $isMonthlyPayDetailView, isInfoSetting: $isInfoSetting, isCalendarModeView: $isCalendarModeView)
                }
                .frame(height: 45)
                
                List {
                    // 선택한 달로 부터 일수를 구함
                    ForEach(calendarViewModel.getCurrentMonth().getAllDate(), id:\.self) { indexDate in
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
                                        self.isAddingNewCodeNoteView.toggle()
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
                                    //withAnimation(.easeInOut(duration: 1)) {
                                    self.isAddingNewCodeNoteView.toggle()
                                    //}
                                    self.indexDate = indexDate
                                }
                        }
                    }
                    .blur(radius: isAddingNewCodeNoteView ?  1.5 : 0.0 )
                }
                .listStyle(.plain)
            }
            .sheet(isPresented: $isMonthlyPayDetailView, content: { MonthlyPayDetailView(notes: selectedMonthNotes) })
            .fullScreenCover(isPresented: $isInfoSetting, content: { PersonInfoSettingView(isInfoSetting: $isInfoSetting) })
            .sheet(isPresented: $isCalendarModeView, content: { CalendarModeView(selectedMonthNotes: selectedMonthNotes)})

            //새로운 코드 입력
            if isAddingNewCodeNoteView {
                BlankView(bgColor: .black)
                    .opacity(isAddingNewCodeNoteView ? 0.5 : 0)
                    .onTapGesture {
                        self.isAddingNewCodeNoteView.toggle()
                    }
                AddingNewCodeNoteView(selectMonthNotes: selectedMonthNotes,
                                      isAddingNewCodeNoteView: $isAddingNewCodeNoteView,
                                      indexDate: $indexDate)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut(duration: 0.2))
            }
        }
        
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
    
    @StateObject static var calendarViewModel = CalendarViewModel()
    
    static var previews: some View {
        MainView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(calendarViewModel)
            //.preferredColorScheme(.dark)
    }
}

/*
 HStack {
     GeometryReader { inLayor in
         HStack {
             Spacer()
             Image(systemName: self.isLeftArrow ? "arrow.right" : "arrow.left")
                 .font(.system(.title, design: .default))
                 .foregroundColor(.mint)
                 .onTapGesture {
                     withAnimation {
                         self.isLeftArrow.toggle()
                     }
                 }
             Image(systemName: "dollarsign.circle.fill")
                 .font(.system(.largeTitle, design: .default))
                 .foregroundColor(.mint)
                 .onTapGesture {
                     self.isMonthlyPayDetailView.toggle()
                 }

             Image(systemName: "person.circle")
                 .font(.largeTitle)
                 .foregroundColor(.blue)
                 .onTapGesture {
                     withAnimation {
                         //  개인 설정 화면
                         self.isInfoSetting.toggle()
                     }
                 }
         }
         .offset(self.isLeftArrow ?
                 CGSize(width: 0, height: 0) :
                 CGSize(width: (outLayor.size.width - inLayor.size.width) - 10, height: 0))
     }

 }
}
 */
