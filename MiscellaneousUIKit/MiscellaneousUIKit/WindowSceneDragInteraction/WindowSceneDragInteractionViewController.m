//
//  WindowSceneDragInteractionViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/20/23.
//

#import "WindowSceneDragInteractionViewController.h"
#import <objc/message.h>

@interface WindowSceneDragInteractionViewController ()

@end

@implementation WindowSceneDragInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemPurpleColor;
    
    UIWindowSceneDragInteraction *interaction = [UIWindowSceneDragInteraction new];
    [self.view addInteraction:interaction];
    
    // _UIWindowSceneDragInteractionImpl_iOS
    NSLog(@"%@", ((id (*)(id, SEL))objc_msgSend)(interaction, NSSelectorFromString(@"impl")));
    
    [interaction release];
}

@end
