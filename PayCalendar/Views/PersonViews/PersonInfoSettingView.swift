//
//  PersonInfoSettingView.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/05.
//

// 통상임금[], 실기본시수[],직위수당,현장수당,근속수당,자기계발비,가족수당,성과급,연장근로수당,휴일/휴무연장근로수당
// 야간근로수당,휴일근로수당,휴무근로수당,야간교대근무수당,월차수당,월할상여

import SwiftUI

struct PersonInfoSettingView: View {
    
    @ObservedObject var personInfoVM = PersonInfoSettingViewModel()
    @Binding var isInfoSetting: Bool
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("개인 설정")
                    .font(.title).fontWeight(.black)
                Spacer()
                Image(systemName: "xmark.circle.fill").font(.largeTitle)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        self.isInfoSetting.toggle()
                    }
            }
            
            List {
                Section {
                    TextField("이름", text: $personInfoVM.personInfo.name)
                    TextField("입사일", text: $personInfoVM.personInfo.inCoLtd)
                    TextField("직급", text: $personInfoVM.personInfo.grade)
                } header: { sectionHeader(text: "프로필") }
                
                Section {
                    TextField("통상 임급", value: $personInfoVM.personInfo.tongsangPay, formatter: numberFormatter)
                    TextField("기본 시수", value: $personInfoVM.personInfo.gibonsisu, formatter: numberFormatter)
                    TextField("연차 발생 수", value: $personInfoVM.personInfo.annnulTotal, formatter: numberFormatter)
                } header: { sectionHeader(text: "기본 사항") }
                
                Section {
                    TextField("현장 수당", value: $personInfoVM.personInfo.hyunjangPay, formatter: numberFormatter)
                    TextField("직위 수당", value: $personInfoVM.personInfo.jicwyPay, formatter: numberFormatter)
                    TextField("근속 수당", value: $personInfoVM.personInfo.gunsokPay, formatter: numberFormatter)
                    TextField("가족 수당", value: $personInfoVM.personInfo.gajokPay, formatter: numberFormatter)
                } header: { sectionHeader(text: "개인 수당") }
            }
            .listStyle(.plain)

            Capsule()
                .frame(width: 100, height: 40)
                .foregroundColor(.purple)
                .overlay(
                    Text("Save")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                )
                .onTapGesture {
                    personInfoVM.saveToJson(person: personInfoVM.personInfo)
                    self.isInfoSetting.toggle()
                }
        }
        .padding()
        .onAppear {
            personInfoVM.personInfo = personInfoVM.loadJson()
            print("\(personInfoVM.personInfo)")
        }
    }
    
    @ViewBuilder
    private func sectionHeader(text: String) -> some View {
        Capsule()
            .frame(maxWidth: .infinity, minHeight: 25)
            .foregroundColor(.green)
            .overlay(
                Text(text)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
            )
    }
}

struct PersonInfoSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonInfoSettingView(isInfoSetting: .constant(false))
    }
}
