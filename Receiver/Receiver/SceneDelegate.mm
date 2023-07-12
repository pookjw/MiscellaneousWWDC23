//
//  SceneDelegate.mm
//  Receiver
//
//  Created by Jinwoo Kim on 7/8/23.
//

#import "SceneDelegate.hpp"
#import <objc/message.h>

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:static_cast<UIWindowScene *>(scene)];
    auto rootViewController = reinterpret_cast<__kindof UIViewController * (*)(Class, SEL)>(objc_msgSend)(NSClassFromString(@"EXAppExtensionBrowserViewController"), @selector(new));
    window.rootViewController = rootViewController;
    [rootViewController release];
    [window makeKeyAndVisible];
    self.window = window;
    [window release];
}

@end
