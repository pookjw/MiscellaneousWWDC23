//
//  DismissalSceneDelegate.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 8/18/23.
//

#import "DismissalSceneDelegate.h"

@class DismissalSceneViewController;
@implementation DismissalSceneDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];
    
    DismissalSceneViewController *rootViewController = [DismissalSceneViewController new];
    window.rootViewController = rootViewController;
    [rootViewController release];
    
    [window makeKeyAndVisible];
    self.window = window;
    [window release];
}

@end

@interface DismissalSceneViewController : UIViewController

@end

@implementation DismissalSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    __block typeof(self) unretained = self;
    
    UIAction *action = [UIAction actionWithTitle:@"Dismiss" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        UIWindowSceneDestructionRequestOptions *options = [UIWindowSceneDestructionRequestOptions new];
        options.windowDismissalAnimation = UIWindowSceneDismissalAnimationStandard;
        
        [UIApplication.sharedApplication requestSceneSessionDestruction:unretained.view.window.windowScene.session
                                                                options:options
                                                           errorHandler:^(NSError * _Nonnull error) {
            
        }];
    }];
    
    UIButton *button = [UIButton systemButtonWithPrimaryAction:action];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

@end
