//
//  SlideButtons.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/08.
//

import SwiftUI

struct SlideButtons: View {
    
    @Binding var isMonthlyPayDetailView: Bool
    @Binding var isInfoSetting: Bool
    
    @State var itemWidth: CGFloat = 35.0
    @State var isArrowTapped: Bool = false
    
    var body: some View {
        
        VStack {
            HStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(.clear)//.opacity(0.2)
                    .overlay (
                        HStack(spacing: 5) {
                            Spacer()
                            Image(systemName: isArrowTapped ? "chevron.right.2" : "chevron.left.2")
                                .foregroundColor(.green)
                                .font(.system(size: self.itemWidth))
                                .onTapGesture {
                                    withAnimation {
                                        self.isArrowTapped.toggle()
                                    }
                                }
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(.blue)
                                .font(.system(size: self.itemWidth))
                                .onTapGesture {
                                    self.isInfoSetting.toggle()
                                }
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor(.pink)
                                .font(.system(size: self.itemWidth))
                                .onTapGesture {
                                    self.isMonthlyPayDetailView.toggle()
                                }
                            Image(systemName: "wonsign.circle")
                                .foregroundColor(.purple)
                                .font(.system(size: self.itemWidth))
                            Image(systemName: "printer.fill")
                                .foregroundColor(.green)
                                .font(.system(size: self.itemWidth))
                        }
                        .offset(self.isArrowTapped ? CGSize(width: 0, height: 0) : CGSize(width: itemWidth * 5.2, height: 0))
                    )
            } // HStack
            
        } // VStack
    }
}

struct SlideButtons_Previews: PreviewProvider {
    static var previews: some View {
        SlideButtons(isMonthlyPayDetailView: .constant(false), isInfoSetting: .constant(false))
    }
}

/*
 VStack {
     HStack {
         Rectangle()
             .frame(maxWidth: .infinity, maxHeight: 50)
             .foregroundColor(.red).opacity(0.2)
             .overlay (
                 HStack(spacing: 5) {
                     Spacer()
                     Image(systemName: isArrowTapped ? "chevron.left.2" : "chevron.right.2")
                         .foregroundColor(.green)
                         .font(.system(size: self.itemWidth))
                         .onTapGesture {
                             withAnimation {
                                 self.isArrowTapped.toggle()
                             }
                         }
                     Image(systemName: "person.crop.circle")
                         .foregroundColor(.blue)
                         .font(.system(size: self.itemWidth))
                     Image(systemName: "doc.text.magnifyingglass")
                         .foregroundColor(.pink)
                         .font(.system(size: self.itemWidth))
                     Image(systemName: "wonsign.circle")
                         .foregroundColor(.purple)
                         .font(.system(size: self.itemWidth))
                     Image(systemName: "printer.fill")
                         .foregroundColor(.green)
                         .font(.system(size: self.itemWidth))
                 }
                 .offset(self.isArrowTapped ? CGSize(width: itemWidth * 5.2, height: 0) : CGSize(width: 0, height: 0))
             )
     } // HStack
     
 } // VStack
 */
