//
//  HelloPieAppApp.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import SwiftUI

@main
struct HelloPieAppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            GuessTheCarLogoView()
            //            ContentView()
            //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}
