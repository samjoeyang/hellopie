//
//  FileManager-DocumentsDirectory.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/27.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
