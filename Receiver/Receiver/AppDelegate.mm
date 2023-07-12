//
//  AppDelegate.mm
//  Receiver
//
//  Created by Jinwoo Kim on 7/8/23.
//

#import "AppDelegate.hpp"
#import "SceneDelegate.hpp"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    UISceneConfiguration *configuration = connectingSceneSession.configuration;
    configuration.delegateClass = SceneDelegate.class;
    return configuration;
}

@end
