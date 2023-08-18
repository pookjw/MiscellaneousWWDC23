//
//  AppDelegate.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "DismissalSceneDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    NSUserActivity * _Nullable userActivity = options.userActivities.allObjects.firstObject;
    
    BOOL isDismissalScene = [userActivity.activityType isEqualToString:@"test"];
    
    UISceneConfiguration *configuration = connectingSceneSession.configuration;
    
    if (isDismissalScene) {
        configuration.delegateClass = DismissalSceneDelegate.class;
    } else {
        configuration.delegateClass = SceneDelegate.class;
    }
    
    return configuration;
}

@end
