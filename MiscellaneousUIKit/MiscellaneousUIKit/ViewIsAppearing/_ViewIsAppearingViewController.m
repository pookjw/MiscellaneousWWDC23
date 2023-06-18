//
//  _ViewIsAppearingViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/18/23.
//

#import "_ViewIsAppearingViewController.h"

@interface _ViewIsAppearingViewController ()

@end

@implementation _ViewIsAppearingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemPurpleColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %d", animated);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %d", animated);
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    NSLog(@"viewIsAppearing %d %@", animated, NSStringFromCGRect(self.view.frame));
}

@end
