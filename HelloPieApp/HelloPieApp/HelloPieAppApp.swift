//
//  HelloPieAppApp.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import SwiftUI

@main
struct HelloPieAppApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            GuessTheCarLogoView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            //            ContentView()
//                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            
            
        }
    }
}
