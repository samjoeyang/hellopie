//
//  carlogoStruct.swift
//  HelloPieApp
//
//  Created by Samjoe Yang on 2022/6/21.
//

import Foundation

struct CarLogo: Codable, Hashable,Identifiable {
    var id = UUID()
    var enName:String
    var cnName:String
    var img:String
    
    init(en:String,cn:String,img:String) {
        self.enName=en
        self.cnName=cn
        self.img=img
    }
    
    static let defaultCarLogo = CarLogo(en:"Car Band",cn: "汽车品牌",img: "default")
}

struct CarLogoCollection: Codable {
    var sample : [CarLogo]
//    static let default = [
//        CarLogo(en: "Audi", cn: "奥迪", img: "audi"),
//        CarLogo(en: "Benz", cn: "奔驰", img: "benz"),
//    ]
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
