//
//  PayCalendarView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/30.
//

import SwiftUI

struct PayCalendarView: View {
    
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
    
    @Binding var isPayCalendar: Bool
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Text("Pay Calendar")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                    Spacer()
                    Button {
                        self.isPayCalendar.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.pink)
                    }

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
                                        withAnimation {
                                            self.isAddingNewCodeNoteView.toggle()
                                        }
                                       
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
                                    withAnimation {
                                        self.isAddingNewCodeNoteView.toggle()
                                    }
                                    self.indexDate = indexDate
                                }
                        }
                    }
                    .blur(radius: isAddingNewCodeNoteView ?  1.5 : 0.0 )
                }
                .listStyle(.plain)
            }
            .sheet(isPresented: $isMonthlyPayDetailView, content: { MonthlyPayDetailView(notes: selectedMonthNotes) })
            .sheet(isPresented: $isCalendarModeView, content: { CalendarModeView(selectedMonthNotes: selectedMonthNotes) })
            .fullScreenCover(isPresented: $isInfoSetting, content: { PersonInfoSettingView(isInfoSetting: $isInfoSetting) })
            
            
            //새로운 코드 입력
            if isAddingNewCodeNoteView {
                BlankView(bgColor: .black)
                    .opacity(isAddingNewCodeNoteView ? 0.5 : 0)
                    .onTapGesture {
                        withAnimation {
                            self.isAddingNewCodeNoteView.toggle()
                        }
                    }
                    //.zIndex(0)
                    .transition(.move(edge: .bottom))
                
                AddingNewCodeNoteView(selectMonthNotes: selectedMonthNotes,
                                      isAddingNewCodeNoteView: $isAddingNewCodeNoteView,
                                      indexDate: $indexDate)
                    .transition(.move(edge: .bottom))
                    .animation(.default.delay(0.2))
                    .onAppear {
                        SoundManager.avkit.playSound(sound: .camera1)
                    }
                    .onDisappear {
                        SoundManager.avkit.playSound(sound: .camera2)
                    }
                    .zIndex(1)
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

struct PayCalendarView_Previews: PreviewProvider {
    //@StateObject static var calendarViewModel = CalendarViewModel()

    static var previews: some View {
//        MainView()
        PayCalendarView(isPayCalendar: .constant(false))
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(CalendarViewModel())
            //.preferredColorScheme(.dark)
    }
}
