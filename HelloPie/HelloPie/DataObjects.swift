//
//  DataObjects.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/5/29.
//

//import Foundation
import SwiftUI

struct UserData: Codable {
    
//    enum CodingKeys: CodingKey {
//        case username,pasword,realname,nickname,mobile,email,token,group,address
//    }
    
    var username: String = ""
    var password: String = ""
    
    var realname: String = ""
    var nickname: String = ""
    var mobile: String = ""
    var email: String = ""
    
    var token: String = ""
    var group: String = "-1"
    var address:[String] = []
    
    static let defaultUser = UserData(nickname:"Guset",group:"-1")
}

struct UserDataCollection: Codable {
    var sample : [UserData]
}



struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount=0

    static let example = Activity(title:"Example activity", description: "This is a test activity.")
}
                                  
class Activities:ObservableObject {
        @Published var activities:[Activity]{
            didSet {
                if let encoded=try? JSONEncoder().encode(activities){
                    UserDefaults.standard.set(encoded,forKey:"Activities")
                }
            }
        }
        init(){
            if let saved=UserDefaults.standard.data(forKey:"Activities"){
                if let decoded = try? JSONDecoder().decode([Activity].self,from:saved) {
                    activities=decoded
                    return
                }
            }  
            activities = []
        }
    }
