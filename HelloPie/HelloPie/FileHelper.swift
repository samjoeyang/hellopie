//
//  FileHelper.swift
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

func getDocumentsDirectory() -> URL {
    // 查找该用户的所有可能的文档目录
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    // 只需返回第一个，应该是唯一的一个
    return paths[0]
}

func writeToFile(data:String,fileName:String) -> Bool{
    
    let url = FileManager.documentsDirectory.appendingPathComponent(fileName)
    
    switch url.pathExtension {
    case "json":
        print(url.pathExtension)
//        let data = try JSONEncoder().encode(data)
    case "txt":
        print(url.pathExtension)
    case "jpg","jpeg":
        print(url.pathExtension)
//        let data = data?.jpegData(compressionQuality: 1.0)
    case "png":
        print(url.pathExtension)
    default:
        print(url.pathExtension)
    }
    
    
    do {
        try data.write(to: url, atomically: true, encoding: .utf8)
        let input = try String(contentsOf: url)
        print(input)
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}
