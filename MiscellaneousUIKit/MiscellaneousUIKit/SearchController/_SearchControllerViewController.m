//
//  _SearchControllerViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/18/23.
//

#import "_SearchControllerViewController.h"

@interface _SearchControllerViewController ()

@end

@implementation _SearchControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemPurpleColor;
    self.contentUnavailableConfiguration = [UIContentUnavailableConfiguration loadingConfiguration];
}

@end
