//
//  LeaveDetailView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/04.
//

import SwiftUI
import Combine

struct LeaveDetailView: View {
    
    @State var isLeaveDetail: Bool = false
    
    private var monthTotal: Double {
        let total = notesForYear.filter {
            $0.leave == "월차"
        }.reduce(0) {
            $0 + $1.wrappedLeave.count
        }
        return total
    }
    
    private var yearTotal: Double {
        let total = notesForYear.filter {
            $0.leave == "연차"
        }.reduce(0) {
            $0 + $1.wrappedLeave.count
        }
        return total
    }
    
    var notesForYear: [NoteEntity]
    
    init(notes: [NoteEntity]) {
        self.notesForYear = notes
    }
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack {
                Text("연차 사용수 : " + String(self.yearTotal))
                Text("월차 사용수 : " + String(self.monthTotal))
            }.font(.system(.caption, design: .default))
            Image(systemName: "questionmark.circle.fill")
                .font(.body).foregroundColor(.purple)
                .onTapGesture {
                    self.isLeaveDetail.toggle()
                }
        }
        .sheet(isPresented: $isLeaveDetail) {
            if let usedLeaves = notesForYear.filter({ $0.wrappedLeave.rawValue == "연차" }).sorted(by: { $0.selectedDay < $1.selectedDay }) {
                LeaveUsedListView(usedLeaves: usedLeaves, isLeaveDetail: $isLeaveDetail)
            }
            
        }
        
    }
}

struct LeaveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveDetailView(notes: [])
            .previewLayout(.sizeThatFits)
    }
}
