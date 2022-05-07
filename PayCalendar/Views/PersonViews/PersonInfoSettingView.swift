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
    @State var isSave: Bool = false
    
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
                    HStack(spacing: 20) {
                        capsuleText("이름", color: .green)
                        TextField("이름", text: $personInfoVM.personInfo.name)
                    }
                    HStack(spacing: 20) {
                        capsuleText("입사일", color: .green)
                        TextField("입사일", text: $personInfoVM.personInfo.inCoLtd)
                    }
                    HStack(spacing: 20) {
                        capsuleText("직급", color: .green)
                        TextField("직급", text: $personInfoVM.personInfo.grade)
                    }
                } header: { sectionHeader(text: "프로필") }
                
                Section {
                    
                    HStack(spacing: 20) {
                        capsuleText("통상 임급", color: .green)
                        TextField("통상 임급", value: $personInfoVM.personInfo.tongsangPay, formatter: numberFormatter)
                        Text("원")
                    }
                    HStack(spacing: 20) {
                        capsuleText("기본 시수", color: .green)
                        TextField("기본 시수", value: $personInfoVM.personInfo.gibonsisu, formatter: numberFormatter)
                        Text("시간")
                    }
                    HStack(spacing: 20) {
                        capsuleText("연차 발생 수", color: .green)
                        TextField("연차 발생 수", value: $personInfoVM.personInfo.annnulTotal, formatter: numberFormatter)
                        Text("개")
                    }

                } header: { sectionHeader(text: "기본 사항") }
                
                Section {
                    HStack(spacing: 20) {
                        capsuleText("현장 수당", color: .green)
                        TextField("현장 수당", value: $personInfoVM.personInfo.hyunjangPay, formatter: numberFormatter)
                        Text("원")
                    }
                    HStack(spacing: 20) {
                        capsuleText("직위 수당", color: .green)
                        TextField("직위 수당", value: $personInfoVM.personInfo.jicwyPay, formatter: numberFormatter)
                        Text("원")
                    }
                    HStack(spacing: 20) {
                        capsuleText("근속 수당", color: .green)
                        TextField("근속 수당", value: $personInfoVM.personInfo.gunsokPay, formatter: numberFormatter)
                        Text("원")
                    }
                    HStack(spacing: 20) {
                        capsuleText("가족 수당", color: .green)
                        TextField("가족 수당", value: $personInfoVM.personInfo.gajokPay, formatter: numberFormatter)
                        Text("원")
                    }
                    
                    
                    
                   
                } header: { sectionHeader(text: "개인 수당") }
            }
            .listStyle(.plain)

            Capsule()
                .frame(width: 100, height: 40)
                .foregroundColor(.purple)
                .scaleEffect(self.isSave ? 0.5 : 1.0)
                .overlay(
                    Text("Save")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .scaleEffect(self.isSave ? 0.5 : 1.0)

                )
                .onTapGesture {
                    withAnimation {
                        self.isSave.toggle()
                    }
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                        personInfoVM.saveToJson(person: personInfoVM.personInfo)
                        self.isInfoSetting.toggle()
                    }
                    
                }
        }
        .padding()
        .onAppear {
            personInfoVM.personInfo = personInfoVM.loadJson()
            print("\(personInfoVM.personInfo)")
        }
    }
    @ViewBuilder
    private func capsuleText(_ text: String, color: Color) -> some View {
        Capsule()
            .frame(width: 80, height: 25)
            .foregroundColor(color)
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(.subheadline, design: .default)).fontWeight(.heavy)
            )
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
