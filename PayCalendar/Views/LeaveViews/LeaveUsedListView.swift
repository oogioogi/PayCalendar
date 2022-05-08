//
//  LeaveUsedListView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/05.
//

import SwiftUI

struct LeaveUsedListView: View {
    
    @Binding var isLeaveDetail: Bool
    
    var usedLeaves: [NoteEntity]
    
    // *****
    // 바인딩 아규먼트 파라메터 설정 방법
    init(usedLeaves: [NoteEntity], isLeaveDetail: Binding<Bool>) {
        self.usedLeaves = usedLeaves
        self._isLeaveDetail = isLeaveDetail
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("연차 사용 날짜")
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
                Image(systemName: "xmark.circle.fill").font(.title)
                    .foregroundColor(.purple)
                    .onTapGesture {
                        self.isLeaveDetail = false
                    }
            }
            List {
                ForEach(usedLeaves, id:\.self) { leave in
                    HStack(spacing: 20) {
                        Text(leave.selectedDate.formattedString)
                        Text(leave.wrappedLeave.rawValue)
                            .foregroundColor(leave.wrappedLeave.rawValue == "연차" ? .red : .blue)
                            .fontWeight(.heavy)
                    }
                    
                }
                
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

struct LeaveUsedListView_Previews: PreviewProvider {
    static var previews: some View {
        LeaveUsedListView(usedLeaves: [], isLeaveDetail: .constant(false))
    }
}
