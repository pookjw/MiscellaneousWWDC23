//
//  MSPath.swift
//  MiscellaneousSwiftUI
//
//  Created by Jinwoo Kim on 8/7/23.
//

import SwiftUI

enum MSPath: String, CaseIterable, Hashable, Identifiable, Sendable {
    case dismissWindowAction = "DismissWindowAction"
    case nunber = "Number"
    
    var id: String {
        rawValue
    }
}
