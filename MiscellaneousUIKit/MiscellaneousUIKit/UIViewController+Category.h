//
//  UIViewController+Category.h
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/28/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Category)
@property (nullable, readonly, nonatomic) UIViewController *mostPresentedViewController;
@end

NS_ASSUME_NONNULL_END
