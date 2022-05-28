//
//  enumList.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI

// 평/휴일/휴무
enum HowWork: String, CaseIterable, Identifiable {
    case weekday = "평일"
    case dayoff = "휴일"
    case dayclosed = "휴무"
    
    var id: Self { self }

    //연장 근로 수당
    var overtimePay: Double {
        switch self {
        case .weekday:
            return 1.0  // 평일 근무
        case .dayoff:
            return 2.0  //휴일 연장 근로 수당
        case .dayclosed:
            return 2.0  //휴무 연장 근로 수당
        }
    }
    
    // 근로 수당
    var workAllowance: Double {
        switch self {
        case .weekday:
            return 1.0  // 평일 근무
        case .dayoff:
            return 1.5  //휴일 근로 수당
        case .dayclosed:
            return 1.5  //휴무 근로 수당
        }
    }
    
    var count: Double {
        switch self {
        case .weekday:
            return 1.0
        case .dayoff:
            return 8.0
        case .dayclosed:
            return 8.0
        }
    }
    
    var image: Image {
        switch self {
        case .weekday:
            return Image("day")
        case .dayoff:
            return Image("weekend")
        case .dayclosed:
            return Image("dayoff")
        }
    }
    
    var index: Int {
        switch self {
        case .weekday:
            return 0
        case .dayclosed:
            return 1
        case .dayoff:
            return 2
        }
    }
    
    var feeling: String {
        switch self {
        case .weekday:
            return "🥱"
        case .dayclosed:
            return "🥵"
        case .dayoff:
            return "😂"
        }
    }
}

// 주간 연장 근로
enum Code: String,CaseIterable, Identifiable {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case Y = "Y"
    case T = "T"
    case N = "N"
    //case none = "none"
    
    var id: Self { self } //Identifiable
    
    var value: Double {
        switch self {
        case .A:
            return 0.0
        case .B:
            return 1.0
        case .C:
            return 2.0
        case .D:
            return 3.0
        case .E:
            return 4.0
        case .F:
            return 5.0
        case .Y:
            return 1.0
        case .T:
            return 2.0
        case .N:
            return 3.0
        //case .none:
        //    return 0.0
        }
    }
    
    var count: Double {
        switch self {
        case .A:
            return 8.0
        case .B:
            return 8.0
        case .C:
            return 8.0
        case .D:
            return 8.0
        case .E:
            return 8.0
        case .F:
            return 8.0
        case .Y:
            return 7.0
        case .T:
            return 7.0
        case .N:
            return 7.0
       //case .none:
       //     return 0.0
        }
    }
    
    var shiftDays: Int {
        switch self {
        case .A:
            return 0
        case .B:
            return 0
        case .C:
            return 0
        case .D:
            return 0
        case .E:
            return 0
        case .F:
            return 0
        case .Y:
            return 1
        case .T:
            return 1
        case .N:
            return 1
        //case .none:
        //    return 0
        }
    }
    
    var feeling: String {
        switch self {
        case .A:
            return "😐"
        case .B:
            return "🙂"
        case .C:
            return "😀"
        case .D:
            return "😃"
        case .E:
            return "😄"
        case .F:
            return "😁"
        case .Y:
            return "😆"
        case .T:
            return "🥹"
        case .N:
            return "😍"
        //case .none:
        //    return "🤬"
        }
    }
    
    var index: Int {
        switch self {
        case .A:
            return 0
        case .B:
            return 1
        case .C:
            return 2
        case .D:
            return 3
        case .E:
            return 4
        case .F:
            return 5
        case .Y:
            return 6
        case .T:
            return 7
        case .N:
            return 8
        //case .none:
        //    return 9
        }
    }
}

enum Leave: String,CaseIterable, Identifiable {
    case none = "근무"
    case annual = "연차"
    case monthly = "월차"
    
    var id: Self { self }
    
    var select: Int {
        switch self {
        case .none:
            return 0
        case.annual:
            return 1
        case.monthly:
            return 2

        }
    }
    
    var count: Double {
        switch self {
        case.monthly:
            return 1.0
        case.annual:
            return 1.0
        case .none:
            return 0.0
        }
    }
    
    var index: Int {
        switch self {
        case .none:
            return 0
        case .annual:
            return 1
        case .monthly:
            return 2

        }
    }
    
    var feeling: String {
        switch self {
        case .none:
            return "🤑"
        case .annual:
            return "😵‍💫"
        case .monthly:
            return "😷"
        }
    }
}

