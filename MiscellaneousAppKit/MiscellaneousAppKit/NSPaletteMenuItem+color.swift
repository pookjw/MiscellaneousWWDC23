//
//  NSPaletteMenuItem+color.swift
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/27/23.
//

import AppKit

extension NSMenuItem {
    @objc var color: NSColor? {
        Mirror(reflecting: self)
            .children
            .first { $0.label == "color" }?
            .value as? NSColor
    }
}
