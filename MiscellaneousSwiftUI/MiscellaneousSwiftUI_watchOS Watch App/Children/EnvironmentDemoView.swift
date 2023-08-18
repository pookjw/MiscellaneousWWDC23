//
//  EnvironmentDemoView.swift
//  MiscellaneousSwiftUI_watchOS Watch App
//
//  Created by Jinwoo Kim on 8/18/23.
//

import SwiftUI

struct EnvironmentDemoView: View {
    @State private var object: _Object = .init()
    
    var body: some View {
        VStack(content: {
            Text(String(describing: object.number))
            
            _StepperView()
                .environment(object)
        })
    }
}

@Observable
private final class _Object {
    var number: Int = .zero
}

private struct _StepperView: View {
    @Environment(_Object.self) private var object
    
    var body: some View {
        Button(action: { object.number += 1 }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    EnvironmentDemoView()
}
