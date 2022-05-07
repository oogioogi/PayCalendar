//
//  PersonInfo.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/07.
//

import Foundation

struct PersonInfo: Codable {
    var name: String
    var grade: String
    var inCoLtd: String
    var tongsangPay: Double
    var gibonsisu: Double
    var hyunjangPay: Double
    var jicwyPay: Double
    var gunsokPay: Double
    var gajokPay: Double
    var annnulTotal: Double
    
    init() {
        self.name = ""
        self.grade = ""
        self.inCoLtd = ""
        self.tongsangPay = 0
        self.gibonsisu = 0
        self.hyunjangPay = 0
        self.jicwyPay = 0
        self.gunsokPay = 0
        self.gajokPay = 0
        self.annnulTotal = 0
    }
}
