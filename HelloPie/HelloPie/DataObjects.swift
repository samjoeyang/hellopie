//
//  DataObjects.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/24.
//

import Foundation
import SwiftUI

struct UserData: Codable,Identifiable, Hashable {
    
    //    enum CodingKeys: CodingKey {
    //        case username,pasword,realname,nickname,mobile,email,token,group,address
    //    }
    var id = UUID()
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
    
//    var isLogin:Bool {
//        self.username.isEmptyEx || self.password.isEmptyEx || self.token.isEmptyEx
//    }
    
    func savecache(userdata:UserData, keyStr:String){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(userdata) {
            UserDefaults.standard.set(data,forKey: keyStr)
            //            self.isLogin=true
        }
    }
    
    func removeCache(keyStr:String){
        UserDefaults.standard.removeObject(forKey: "UserData")
        //        self.isLogin = false
    }
}

struct UserDataCollection: Codable {
    var sample : [UserData]
}

struct CarLogoData: Codable, Identifiable, Hashable  {
    var id = UUID()
    var enName:String
    var cnName:String
    var img:String
    
    init(en:String,cn:String,img:String) {
        self.enName=en
        self.cnName=cn
        self.img=img
    }
    
    static let defaultCarLogo = CarLogoData(en:"Car Band",cn: "汽车品牌",img: "default")
}

struct CarLogoDataCollection: Codable {
    var sample : [CarLogoData]
    static let `default` = [
        CarLogoData(en: "Audi", cn: "奥迪", img: "audi"),
        CarLogoData(en: "Benz", cn: "奔驰", img: "benz"),
    ]
}

class CarLogosData:ObservableObject {
    @Published var carlogos:[CarLogoData] {
        didSet {
            if let encoded=try? JSONEncoder().encode(carlogos){
                UserDefaults.standard.set(encoded,forKey:"CarLogos")
            }
        }
    }
    init(){
        if let saved=UserDefaults.standard.data(forKey:"CarLogos"){
            if let decoded = try? JSONDecoder().decode([CarLogoData].self,from:saved) {
                carlogos=decoded
                return
            }
        }
        carlogos = []
    }
}

struct InnerAppsData<Content:View> {
    var appName : String
    var bgColor : Color
    var Content : () -> Content
    
    //    static let defaultData = InnerAppsData(appName: "App Name", bgColor: Color.pink, Content: { Text("Test View") as! Content })
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
