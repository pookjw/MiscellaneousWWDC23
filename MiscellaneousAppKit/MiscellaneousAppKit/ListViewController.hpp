//
//  ListViewController.hpp
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

static NSNotificationName const NSNotificationNameListViewControllerDidSelectClass = @"NSNotificationNameListViewControllerDidSelectClass";
static NSString * const ListViewControllerDidSelectClassKey = @"ListViewControllerDidSelectClassKey";

@interface ListViewController : NSViewController

@end

NS_ASSUME_NONNULL_END
