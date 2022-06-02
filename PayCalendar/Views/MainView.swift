//
//  MainView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI

struct MainView: View {
    
    let persistenceController = PersistenceController.shared
    @StateObject var calendarViewModel = CalendarViewModel()
    @State var isPayCalendar: Bool = false
    @State var backColor = Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))
    @State var todoBackColor = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "face.smiling.fill")
                    .font(.largeTitle)
                Text("Be Happy My Life")
                    .fontWeight(.heavy)
                    .font(.system(.largeTitle, design: .rounded))
            }
            .padding()
            .foregroundColor(.white)
            .background(backColor.cornerRadius(20)).opacity(0.9)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10.0) {
                Image(systemName: "calendar")
                    .font(.largeTitle)
                Text("Pay Calendar")
                    .font(.headline)
                Text("일일 근무 코드 기록장")
                    .font(.subheadline)
            }
            .padding()
            .foregroundColor(.white)
            .background(backColor.cornerRadius(20))
            .onTapGesture {
                self.isPayCalendar.toggle()
            }
            
            VStack(alignment: .leading, spacing: 10.0) {
                Image(systemName: "text.badge.checkmark")
                    .font(.largeTitle)
                Text("To Do List")
                    .font(.headline)
                Text("일일 할일 리스트")
                    .font(.subheadline)
            }
            .padding()
            .foregroundColor(.white)
            .background(todoBackColor.cornerRadius(20))
            .onTapGesture {
                self.isPayCalendar.toggle()
            }
            
            .fullScreenCover(isPresented: $isPayCalendar) {
                PayCalendarView(isPayCalendar: $isPayCalendar)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(calendarViewModel)
            }
            Spacer()
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
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
