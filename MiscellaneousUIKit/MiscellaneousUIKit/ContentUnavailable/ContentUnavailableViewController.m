//
//  ContentUnavailableViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/6/23.
//

#import "ContentUnavailableViewController.h"

@interface ContentUnavailableViewController ()
@property (retain) UIContentUnavailableView *contentUnavilableView;
@end

@implementation ContentUnavailableViewController

- (void)dealloc{
    [_contentUnavilableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UIContentUnavailableConfiguration *configuration = [UIContentUnavailableConfiguration loadingConfiguration];
    configuration.alignment = UIContentUnavailableAlignmentCenter;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"Test"];
    configuration.attributedText = attributedText;
    [attributedText release];
    
    UIBackgroundConfiguration *backgroud = [UIBackgroundConfiguration clearConfiguration];
    backgroud.backgroundColor = UIColor.systemGrayColor;
    configuration.background = backgroud;
    
    UIButtonConfiguration *button = [UIButtonConfiguration tintedButtonConfiguration];
    button.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
    button.title = @"Button!";
    configuration.button = button;
    configuration.buttonProperties.primaryAction = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        NSLog(@"Hello World!");
    }];
    
    UIButtonConfiguration *secondaryButton = [UIButtonConfiguration borderedProminentButtonConfiguration];
    secondaryButton.cornerStyle = UIButtonConfigurationCornerStyleDynamic;
    secondaryButton.title = @"Secondary!";
    configuration.secondaryButton = secondaryButton;
    UIAction *testAction1 = [UIAction actionWithTitle:@"Test" image:[UIImage systemImageNamed:@"heart"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }];
    UIAction *testAction2 = [UIAction actionWithTitle:@"Test" image:[UIImage systemImageNamed:@"heart.fill"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }];
    
    testAction2.attributes = UIMenuElementAttributesKeepsMenuPresented;
    
    UIMenu *menu = [UIMenu menuWithTitle:@"Menu" image:[UIImage systemImageNamed:@"heart.fill"] identifier:nil options:UIMenuOptionsDisplayAsPalette children:@[testAction1, testAction2]];
    configuration.secondaryButtonProperties.menu = menu;
    
    UIContentUnavailableView *contentUnavilableView = [[UIContentUnavailableView alloc] initWithConfiguration:configuration];
    contentUnavilableView.scrollEnabled = YES;
    contentUnavilableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:contentUnavilableView];
    [NSLayoutConstraint activateConstraints:@[
        [contentUnavilableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [contentUnavilableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [contentUnavilableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [contentUnavilableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    self.contentUnavilableView = contentUnavilableView;
    [contentUnavilableView release];
}

@end
