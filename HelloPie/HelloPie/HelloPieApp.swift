//
//  HelloPieApp.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/24.
//

import SwiftUI

@main
struct HelloPieApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
//            GuessTheCarLogoView()
            ContentView()
                .environment(\.locale, .init(identifier: "zh-Hans"))
                .environment(\.managedObjectContext, dataController.container.viewContext)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
