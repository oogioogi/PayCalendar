//
//  PayCalendarApp.swift
//  PayCalendar
//
//  Created by 이용석 on 2022/05/02.
//

import SwiftUI

@main
struct PayCalendarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
