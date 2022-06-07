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
    @State var iconTinggle: Bool = false
    @State var isClicked: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color("fgLiteral"), Color("bgLiteral")],
                           center: .bottom,
                           startRadius: 10,
                           endRadius: UIScreen.main.bounds.height).ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                topTitle
                
                Spacer()

                if isClicked {
                    VStack {
                        paycalendar
                        todolist
                    }
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
                }else {
                    Text("Please Press Plus Button..")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }

                Spacer()

                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: isClicked ? 45 : 0))
                    .scaleEffect(isClicked ? 1.5 : 1)
                    .onTapGesture {
                        withAnimation {
                            isClicked.toggle()
                        }
                    }
                
            }
            .fullScreenCover(isPresented: $isPayCalendar) {
                PayCalendarView(isPayCalendar: $isPayCalendar)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(calendarViewModel)
            }
            
        }

    }
    
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


extension MainView {
    
    // title
    var topTitle: some View {
        HStack {
            Image(systemName: "face.smiling.fill")
                .font(.largeTitle)
            Text("Be Happy My Life")
                .fontWeight(.heavy)
                .font(.system(.largeTitle, design: .rounded))
        }
        .padding()
        .foregroundColor(.white)
        .background(Color("fgLiteral").cornerRadius(20))
        .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
    
    // Paycalendar View
    var paycalendar: some View {
        
        VStack(alignment: .leading, spacing: 10.0) {
            Image(systemName: "calendar")
                .font(.largeTitle)
                .shadow(color: .black, radius: 2, x: 2, y: 2)
                .rotation3DEffect(Angle(degrees: iconTinggle ? 360 : 0),axis: (x: 0, y: 1, z: 0))
            Text("Pay Calendar")
                .font(.headline)
            Text("일일 근무 코드 기록장")
                .font(.subheadline)
        }
        .frame(width: UIScreen.main.bounds.width * 0.5)
        .padding(.vertical, 20)
        .foregroundColor(.white)
        .background(Color("fgLiteral").cornerRadius(20))
        .shadow(color: .black, radius: 5, x: 2, y: 2)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                iconTinggle.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isPayCalendar.toggle()
            }
        }
    }
    
    // todolist View
    var todolist: some View {
        
        VStack(alignment: .leading, spacing: 10.0) {
            Image(systemName: "text.badge.checkmark")
                .font(.largeTitle)
            Text("To Do List")
                .font(.headline)
            Text("일일 할일 리스트")
                .font(.subheadline)
        }
        .frame(width: UIScreen.main.bounds.width * 0.5)
        .padding(.vertical, 20)
        .foregroundColor(.white)
        .background(Color("fgLiteral").cornerRadius(20))
        .shadow(color: .black, radius: 5, x: 2, y: 2)
        .onTapGesture {
           //
        }
    }
}
