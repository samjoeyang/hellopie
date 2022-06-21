//
//  Utils.swift
//  HelloPie
//
//  Created by SamjoeYang on 2022/5/31.
//

import SwiftUI

extension String {
    var isEmptyEx:Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
