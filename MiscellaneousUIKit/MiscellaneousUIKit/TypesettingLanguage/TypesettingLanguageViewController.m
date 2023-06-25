//
//  TypesettingLanguageViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/26/23.
//

#import "TypesettingLanguageViewController.h"

@interface TypesettingLanguageViewController ()

@end

@implementation TypesettingLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.backgroundColor = UIColor.systemPurpleColor;
    
//    label.sizingRule = UILetterformAwareSizingRuleOversize;
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleLargeTitle];
    label.text = @"rrrrrrअभिज्ञानशाकुन्तलम्";
    
    // See the difference - UIKit will adjust line-height and hyphenation rules.
//    label.traitOverrides.typesettingLanguage = @"en";
    label.traitOverrides.typesettingLanguage = @"th";
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [label.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    [label release];
}

@end
