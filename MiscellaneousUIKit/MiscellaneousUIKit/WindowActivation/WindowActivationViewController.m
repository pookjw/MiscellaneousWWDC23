//
//  WindowActivationViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 8/18/23.
//

#import "WindowActivationViewController.h"

@interface WindowActivationViewController ()

@end

@implementation WindowActivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UIWindowSceneActivationAction *action = [UIWindowSceneActivationAction actionWithIdentifier:nil
                                                                                alternateAction:nil
                                                                          configurationProvider:^UIWindowSceneActivationConfiguration * _Nullable(__kindof UIWindowSceneActivationAction * _Nonnull action) {
        NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:@"test"];
        UIWindowSceneActivationConfiguration *configuration = [[UIWindowSceneActivationConfiguration alloc] initWithUserActivity:userActivity];
        [userActivity release];
        return [configuration autorelease];
    }];
    
    UIButtonConfiguration *configuration = [UIButtonConfiguration plainButtonConfiguration];
    configuration.title = @"UIWindowSceneActivationAction";
    
    UIButton *button = [UIButton buttonWithConfiguration:configuration primaryAction:action];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

@end
