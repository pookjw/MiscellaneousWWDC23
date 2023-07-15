//
//  AppDelegate.m
//  MyApp
//
//  Created by Jinwoo Kim on 7/15/23.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"A");
        [NSApp activate];
    });
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    NSLog(@"%@", notification);
}

@end
