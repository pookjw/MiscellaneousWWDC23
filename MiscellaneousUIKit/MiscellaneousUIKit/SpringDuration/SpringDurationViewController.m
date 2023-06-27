//
//  SpringDurationViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/28/23.
//

#import "SpringDurationViewController.h"
#import <time.h>

@interface SpringDurationViewController ()

@end

@implementation SpringDurationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UIButtonConfiguration *configuration = [UIButtonConfiguration plainButtonConfiguration];
    configuration.title = @"Move!";
    
    UIButton *button = [UIButton buttonWithConfiguration:configuration primaryAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        UIButton *button = (UIButton *)action.sender;
        
        __block NSLayoutConstraint * _Nullable constraint = nil;
        [button.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.firstAttribute == NSLayoutAttributeCenterX) {
                constraint = obj;
                *stop = YES;
            }
        }];
        
        srand((unsigned int)time(NULL));
        int random_integer = rand() % 101 - 50;
        constraint.constant = (float)random_integer;
        
        [UIView animateWithSpringDuration:1.f bounce:0.2f initialSpringVelocity:0.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
            [button.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }]];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

@end
