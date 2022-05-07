//
//  PersonInfoSettingViewModel.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/07.
//

import Foundation
import SwiftUI

class PersonInfoSettingViewModel: ObservableObject {
    
    @Published var personInfo: PersonInfo
    
    init() {
        self.personInfo = PersonInfo()
    }
    
    func saveToJson(person: PersonInfo) {
        do {
            let encodeData = try JSONEncoder().encode(person)
            let defaults = UserDefaults.standard
            defaults.setValue(encodeData, forKey: "SavedPersonInfo")
            
        } catch let error {
            print("Json Encode Error : \(error.localizedDescription)")
        }
    }
    
    func loadJson() -> PersonInfo {
        
        do {
            if let savedPersonInfo = UserDefaults.standard.object(forKey: "SavedPersonInfo") as? Data {
                let decodeData = try JSONDecoder().decode(PersonInfo.self, from: savedPersonInfo)
                return decodeData
            }
            
        } catch let error {
            print("Json file Decode Error : \(error.localizedDescription)")
        }
        return PersonInfo()
    }
}
