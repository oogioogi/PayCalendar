//
//  NoteEntity.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import Foundation
import CoreData

public class NoteEntity: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var selectedDate: Date // 선택 날짜
    @NSManaged public var selectedDay: Int32 // 선택 일
    @NSManaged public var selectedMonth: Int32 // 선택 월
    @NSManaged public var selectedCode: String // 선택 코드
    @NSManaged public var howwork: String // 근무 형태
    @NSManaged public var leave: String // 휴가 = 연.월
    
    var wrappedLeave: Leave {
        set {
            self.leave = newValue.rawValue
        }
        get {
            Leave(rawValue: leave) ?? .none
        }
    }
    
    var wrappedCode: Code {
        set {
            self.selectedCode = newValue.rawValue
        }
        get {
            Code(rawValue: selectedCode) ?? .A
        }
    }
    
    var wrappedHowwork: HowWork {
        set {
            self.howwork = newValue.rawValue
        }
        get {
            HowWork(rawValue: howwork) ?? .weekday
        }
    }
}
