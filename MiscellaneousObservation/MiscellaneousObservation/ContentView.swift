//
//  ContentView.swift
//  MiscellaneousObservation
//
//  Created by Jinwoo Kim on 7/6/23.
//

import SwiftUI
import Combine

@objc(Foo) class Foo: NSObject {
    let context: UnsafeMutableRawPointer = .allocate(byteCount: 1, alignment: 1)
    
    override init() {
        super.init()
        addObserver(self, forKeyPath: #keyPath(Foo.text), context: context)
    }
    
    deinit {
        context.deallocate()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if self.context == context {
            print(object) // 불림!
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    @objc var text: NSString? {
        willSet {
            willChangeValue(forKey: #keyPath(Foo.text))
        }
        didSet {
            didChangeValue(forKey: #keyPath(Foo.text))
        }
    }
}

let foo: Foo = .init()
let obs = foo.observe(\.text, options: [.initial, .new]) { _, _ in
    print("HEllo")
}

struct ContentView: View {
    @State var flag = false
    
    var body: some View {
        Button {
            obs
            flag.toggle()
            foo.text = flag ? "A" : "B"
//            foo.setValue(flag ? "A" : "B", forKey: #keyPath(Foo.text))
//            foo.perform(#selector(setter: Foo.text), with: flag ? "A" : "B")
        } label: {
            Text("Toggle!")
        }
    }
}

//struct ContentView: View {
//    @StateObject var fruit: Fruit = .init(text: "🍓")
//    @State var flag = false
//    
//    var body: some View {
//        Button {
//            flag.toggle()
//            fruit.text = flag ? "🎃" : "🍓"
////            fruit.setValue(flag ? "🎃" : "🍓", forKey: "text")
////            print(fruit.text)
//        } label: {
//            Text(fruit.text as String)
//        }
//        .task {
////            #selector(Fruit.setText(_:))
////            for await value in fruit.publisher(for: \.text, options: [.initial, .new]).values {
////                print(value)
////            }
//        }
//    }
//}

#Preview {
    ContentView()
}
