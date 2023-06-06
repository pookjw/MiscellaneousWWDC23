//
//  SceneDelegate.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "SceneDelegate.h"
#import "FeaturesViewController.h"

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    FeaturesViewController *featuresViewController = [FeaturesViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:featuresViewController];
    [featuresViewController release];
    
    window.rootViewController = navigationController;
    [navigationController release];
    
    [window makeKeyAndVisible];
    self.window = window;
    [window release];
}

@end
