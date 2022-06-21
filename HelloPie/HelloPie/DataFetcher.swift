//
//  DataFetcher.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/5/29.
//

import SwiftUI

//@MainActor
//class DataFetcher: ObservedObject {
//    @Published var returnData = ReturnDataCollection(sample: [UserData.defaultUser])
//    @Published var currentUser = UserData.defaultUser
//
//    enum FetchError: Error{
//        case badRequest
//        case badJSON
//    }
//
//    let urlString:String = ""
//
//    @available(iOS 15.0,*)
//    func fetchData() async
//    throws {
//        guard let url = URL(string: urlString) else { return }
//        let (data,response) = try await URLSession.shared.data(for:URLRequest(url: url))
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }
//
//        returnData = try JSONDecoder().decode(ReturnDataCollection.self, from: data)
//    }
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
