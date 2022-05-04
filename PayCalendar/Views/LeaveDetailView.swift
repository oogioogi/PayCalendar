//
//  LeaveDetailView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/04.
//

import SwiftUI
import Combine

struct LeaveDetailView: View {
    
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
        
        VStack {
            Text("연차 사용수 : " + String(self.yearTotal))
            Text("월차 사용수 : " + String(self.monthTotal))
        }.font(.system(.caption, design: .default))
        
    }
}

struct LeaveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveDetailView(notes: [])
            .previewLayout(.sizeThatFits)
    }
}
