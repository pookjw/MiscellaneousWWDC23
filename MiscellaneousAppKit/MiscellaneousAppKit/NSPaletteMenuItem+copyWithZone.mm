//
//  NSPaletteMenuItem+copyWithZone.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/27/23.
//

#import "NSPaletteMenuItem+copyWithZone.hpp"
#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "MiscellaneousAppKit-Swift.h"

namespace NSPaletteMenuItem {

namespace initWithTitle_action_keyEquivalent {
id (*original)(id, SEL, id, SEL, id);
id custom(id self, SEL _cmd, id title, SEL action, id keyEquivalent) {
    struct objc_super superInfo = { self, [self superclass] };
    self = reinterpret_cast<id (*)(struct objc_super *, SEL, id, SEL, id)>(objc_msgSendSuper)(&superInfo, _cmd, title, action, keyEquivalent);
    
    return self;
}
}

namespace copyWithZone {
id custom(id self, SEL _cmd, struct _NSZone *zone) {
    struct objc_super superInfo = { self, [self superclass] };
    auto copy = reinterpret_cast<NSMenuItem * (*)(struct objc_super *, SEL, struct _NSZone *)>(objc_msgSendSuper)(&superInfo, _cmd, zone);
    
    id color = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self, @selector(color));
    
    copy = reinterpret_cast<id (*)(id, SEL, id, id, id)>(objc_msgSend)(copy, NSSelectorFromString(@"initWithColor:image:title:"), color, copy.image, copy.title);
    
    return copy;
}
}

}

void registerNSPaletteMenuItemCopyMethod() {
    Method method_1 = class_getInstanceMethod(NSClassFromString(@"NSPaletteMenuItem"), @selector(initWithTitle:action:keyEquivalent:));
    NSPaletteMenuItem::initWithTitle_action_keyEquivalent::original = reinterpret_cast<id (*)(id, SEL, id, SEL, id)>(method_getImplementation(method_1));
    method_setImplementation(method_1, reinterpret_cast<IMP>(NSPaletteMenuItem::initWithTitle_action_keyEquivalent::custom));
    
    class_addMethod(NSClassFromString(@"NSPaletteMenuItem"), @selector(copyWithZone:), reinterpret_cast<IMP>(NSPaletteMenuItem::copyWithZone::custom), nullptr);
}
