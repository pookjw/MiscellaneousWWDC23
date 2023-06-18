//
//  ViewIsAppearingViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/18/23.
//

#import "ViewIsAppearingViewController.h"
#import "_ViewIsAppearingViewController.h"

@interface ViewIsAppearingViewController ()

@end

@implementation ViewIsAppearingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    [self foo];
}

- (void)foo {
    _ViewIsAppearingViewController *child = [_ViewIsAppearingViewController new];
    
    NSLog(@"addChildViewController");
    [self addChildViewController:child];
    child.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSLog(@"addSubview");
    [self.view addSubview:child.view];
    
    NSLog(@"didMoveToParentViewController");
    [child didMoveToParentViewController:self];
    [child release];
}

@end
