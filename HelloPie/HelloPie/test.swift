//
//  test.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/5/29.
//

import SwiftUI

struct test: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                LazyVStack{
                        ForEach (0..<100) {
                            Text("Row \($0)")
                        }
                    
                }
            }
            .navigationBarTitle("Swift")
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
