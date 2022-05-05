//
//  PersonInfoSettingView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/05.
//

import SwiftUI

struct PersonInfoSettingView: View {
    
    @Binding var isInfoSetting: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "xmark.circle.fill").font(.largeTitle)
                .onTapGesture {
                    self.isInfoSetting.toggle()
                }
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("Hello, World!")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct PersonInfoSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonInfoSettingView(isInfoSetting: .constant(false))
    }
}
