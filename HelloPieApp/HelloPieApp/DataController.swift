//
//  DataController.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "HelloPieApp")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
