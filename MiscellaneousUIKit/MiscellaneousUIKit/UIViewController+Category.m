//
//  UIViewController+Category.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/28/23.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

- (UIViewController *)mostPresentedViewController {
    UIViewController * _Nullable result = self;
    
    while (result) {
        UIViewController * _Nullable tmp = result.presentedViewController;
        
        if (tmp) {
            result = tmp;
        } else {
            return result;
        }
    }

    return nil;
}

@end
