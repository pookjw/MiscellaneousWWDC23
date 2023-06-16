//
//  LefferformAwareAdjustingViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/17/23.
//

#import "LefferformAwareAdjustingViewController.h"

@interface LefferformAwareAdjustingViewController ()
@property (retain) UILabel *label;
@end

@implementation LefferformAwareAdjustingViewController

- (void)dealloc {
    [_label release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.backgroundColor = UIColor.systemPurpleColor;
    
    label.sizingRule = UILetterformAwareSizingRuleOversize;
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleLargeTitle];
    label.text = @"अभिज्ञानशाकुन्तलम्";
    
    // Differ
    NSLog(@"%@", NSStringFromCGSize(label.intrinsicContentSize));
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    self.label = label;
    [label release];
}

@end
