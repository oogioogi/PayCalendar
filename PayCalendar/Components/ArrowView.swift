//
//  ArrowView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/08.
//

import SwiftUI

struct ArrowView: View {
    
    @Binding var monthCount: Int
    
    var body: some View {
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
        }
        .font(.title).foregroundColor(.purple)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView(monthCount: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
