//
//  Fruit.swift
//  MiscellaneousObservation
//
//  Created by Jinwoo Kim on 7/6/23.
//

import Foundation
import Observation

//@Observable
@objc(Fruit)
final class Fruit: NSObject, ObservableObject {
    var text: NSString
    
    @objc
    init(text: String) {
        self.text = text as NSString
        super.init()
    }
}

//actor _Fruit: Observation.Observable {
//    
//}
