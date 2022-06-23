//
//  carlogoStruct.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import Foundation

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

//{
//    "enName":"Audi";
//    "cnName":"奥迪";
//    "img":"audi";
//},{
//    "enName":"Benz";
//    "cnName":"奔驰";
//    "img":"benz";
//},{
//    "enName":"BMW";
//    "cnName":"宝马";
//    "img":"bmw";
//},{
//    "enName":"Citroen";
//    "cnName":"雪铁龙";
//    "img":"citroen";
//},{
//    "enName":"Ford";
//    "cnName":"雪福特龙";
//    "img":"ford";
//},{
//    "enName":"Ford";
//    "cnName":"雪福特龙";
//    "img":"ford";
//}
