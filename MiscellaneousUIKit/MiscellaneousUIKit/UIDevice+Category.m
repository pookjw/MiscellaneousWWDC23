//
//  UIDevice+Category.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "UIDevice+Category.h"
#import <objc/message.h>
#import <objc/runtime.h>

static UIUserInterfaceIdiom (*original_UIDevice_userInterfaceIdiom)(id self, SEL _cmd);

static UIUserInterfaceIdiom custom_UIDevice_userInterfaceIdiom(id self, SEL _cmd) {
//    return UIUserInterfaceIdiomReality;
    return original_UIDevice_userInterfaceIdiom(self, _cmd);
//    return UIUserInterfaceIdiomTV;
};


@implementation UIDevice (Category)

+ (void)load {
    Method original = class_getInstanceMethod(self, @selector(userInterfaceIdiom));
    original_UIDevice_userInterfaceIdiom = (UIUserInterfaceIdiom (*)(id self, SEL _cmd))method_getImplementation(original);
    method_setImplementation(original, (IMP)custom_UIDevice_userInterfaceIdiom);
}

@end
