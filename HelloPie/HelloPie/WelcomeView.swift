//
//  WelcomeView.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Hello, Pie")
            .font(.largeTitle)
            .foregroundColor(.orange)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environment(\.locale, .init(identifier: "zh-Hans"))
    }
}
