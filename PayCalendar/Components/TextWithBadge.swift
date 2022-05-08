//
//  TextWithBadge.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI
import Combine

struct TextWithBadge: View {
    var year: String = "2022"
    var month: Int32 = 1
    
    // String.Element = Charactor
    var years: [String.Element] {
        return year.compactMap({$0})
    }
    
    var randomColor: [Color] = [.yellow, .pink, .purple, .blue, .green, .cyan, .brown]
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 3) {
                 ForEach(years, id: \.self) {
                     Text($0.description)
                         .frame(width: 30, height: 30)
                         .font(.system(size: 20, weight: .heavy, design: .rounded))
                         .foregroundColor(.white)
                         .background(randomColor[.random(in: 0...6)])
                         .clipShape(Circle())
                         //.offset(x: 0, y: .random(in: -5...5))
                         //.shadow(color: .primary, radius: 1.0, x: 3, y: 3)
                 }
                 
                 Circle().frame(width: 5, height: 5)//.offset(x: 0, y: 10)
                 
                 Text("\(month)")
                     .frame(width: 30, height: 30)
                     .font(.system(size: 20, weight: .heavy, design: .rounded))
                     .foregroundColor(.white)
                     .background(Color.yellow)
                     .clipShape(Circle())
                     //.offset(x: 0, y: .random(in: -5...5))
                     //.shadow(color: .primary, radius: 1.0, x: 3, y: 3)
             }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

struct TextWithBadge_Previews: PreviewProvider {
    static var previews: some View {
        TextWithBadge()
    }
}
