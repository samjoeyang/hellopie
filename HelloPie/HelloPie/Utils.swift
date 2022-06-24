//
//  Utils.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/6/24.
//

import SwiftUI

extension String {
    var isEmptyEx:Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
