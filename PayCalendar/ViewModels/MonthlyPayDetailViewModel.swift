//
//  MonthlyPayDetailViewModel.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/04.
//

import Foundation

class MonthlyPayDetailViewModel: ObservableObject {

    @Published var notes: [NoteEntity] = []
    
    var personInfoVM = PersonInfoSettingViewModel()
    
    init(notes: [NoteEntity]) {
        self.notes = notes
        personInfoVM.personInfo = personInfoVM.loadJson()
    }
    
    
    // 연장 근무 합계
        public var daysOverTime: Double {
            let total = notes.filter {
                $0.leave == "근무" && $0.howwork == "평일"
            }.reduce(0) {
                $0 + $1.wrappedCode.value
            }
            return total
        }

    // 휴일/휴무 연장 근무 합계
        public var dayoffsOverTime: Double {
            let total = notes.filter {
                $0.leave == "근무" && ($0.howwork == "휴일" || $0.howwork == "휴무")
            }.reduce(0) {
                $0 + $1.wrappedCode.value
            }
            return total
        }

    // 휴일 근무 합계
        public var countDayoffs: Double {
            let total = notes.filter {
                $0.leave == "근무" && $0.howwork == "휴일"
            }.reduce(0) {
                $0 + $1.wrappedHowwork.count
            }
            return total
        }

    // 휴무 근무 합계
        public var countDaycloses: Double {
            let total = notes.filter {
                $0.leave == "근무" && $0.howwork == "휴무"
            }.reduce(0) {
                $0 + $1.wrappedHowwork.count
            }
            return total
        }

    // 야간 근무 합계
        public var countNights: Double {
            let total = notes.filter {
                $0.leave == "근무" && ($0.selectedCode == "Y" || $0.selectedCode == "T" || $0.selectedCode == "N")
            }.reduce(0) {
                $0 + $1.wrappedCode.count
            }
            return total
        }

    // 야간 교대일수
        public var countNightShiftDays: Int {
            let total = notes.filter {
                $0.leave == "근무" && ($0.selectedCode == "Y" || $0.selectedCode == "T" || $0.selectedCode == "N")
            }.reduce(0) {
                $0 + $1.wrappedCode.shiftDays
            }
            return total
        }

    // 연차 사용수
        public var countAnnuals: Double {
            let total = notes.filter {
                $0.leave == "월차"
            }.reduce(0) {
                $0 + $1.wrappedLeave.count
            }
            return total
        }

     //연장 근로 수당
     //(통상임금/243)*연장근무*1.5
        public func overTimePay() -> Double {
            //let normalwage: Double = 4205761    // 통상임금
            //let gibonSisu: Double = 243 // 기본시수

            let pay = (personInfoVM.personInfo.tongsangPay/personInfoVM.personInfo.gibonsisu) * daysOverTime * 1.5
            return pay
        }

    // 휴일 휴무 연장 근로 수당
    // (통상임금/243)*연장근무*1.5
        public func dayoffOverTimePay() -> Double {
            //let normalwage: Double = 4205761    // 통상임금
            //let gibonSisu: Double = 243 // 기본시수

            let pay = (personInfoVM.personInfo.tongsangPay/personInfoVM.personInfo.gibonsisu) * dayoffsOverTime * 1.5

            return pay
        }

    // 야간 근로 수당
    // (통상임금/243)*야간 근로*1.5
        public func nightPay() -> Double {
            //let normalwage: Double = 4205761    // 통상임금
            //let gibonSisu: Double = 243 // 기본시수

            let pay = (personInfoVM.personInfo.tongsangPay/personInfoVM.personInfo.gibonsisu) * countNights * 0.5

            return pay
        }

    // 휴일 휴무 연장 근로 수당
    // (통상임금/243)*연장근무*1.5
        public func dayoffPay() -> Double {
            //let normalwage: Double = 4205761    // 통상임금
            //let gibonSisu: Double = 243 // 기본시수

            let pay = (personInfoVM.personInfo.tongsangPay/personInfoVM.personInfo.gibonsisu) * countDayoffs * 1.5

            return pay
        }

    // 야간 근로 수당
    // (통상임금/243)*야간 근로*1.5
        public func dayClosedPay() -> Double {
            //let normalwage: Double = 4205761    // 통상임금
            //let gibonSisu: Double = 243 // 기본시수
            let pay = (personInfoVM.personInfo.tongsangPay/personInfoVM.personInfo.gibonsisu) * countDaycloses * 1.5

            return pay
        }
    // 야간 교대 수당
    // 4000 * 교대일수
        public func nightShiftDaysPay() -> Double {
            let pay = 4000.0 * Double(countNightShiftDays)
            return pay
        }
    
}
