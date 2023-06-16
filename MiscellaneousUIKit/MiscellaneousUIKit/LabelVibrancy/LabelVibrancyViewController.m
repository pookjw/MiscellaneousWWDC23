//
//  LabelVibrancyViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/17/23.
//

#import "LabelVibrancyViewController.h"

@interface LabelVibrancyViewController ()
@property (retain) UIImageView *imageView;
@property (retain) UIVisualEffectView *blurView;
@property (retain) UIVisualEffectView *vibrancyView;
@property (retain) UILabel *label;
@end

@implementation LabelVibrancyViewController

- (void)dealloc {
    [_imageView release];
    [_blurView release];
    [_vibrancyView release];
    [_label release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupImageView];
    [self setupBlurView];
    [self setupVibrancyView];
    [self setupLabel];
}

- (void)setupImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    [imageView release];
}

- (void)setupBlurView {
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterialDark]];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blurView];
    [NSLayoutConstraint activateConstraints:@[
        [blurView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [blurView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [blurView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [blurView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    self.blurView = blurView;
    [blurView release];
}

- (void)setupVibrancyView {
    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial]]];
    vibrancyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.blurView.contentView addSubview:vibrancyView];
    [NSLayoutConstraint activateConstraints:@[
        [vibrancyView.topAnchor constraintEqualToAnchor:self.blurView.contentView.topAnchor],
        [vibrancyView.leadingAnchor constraintEqualToAnchor:self.blurView.contentView.leadingAnchor],
        [vibrancyView.trailingAnchor constraintEqualToAnchor:self.blurView.contentView.trailingAnchor],
        [vibrancyView.bottomAnchor constraintEqualToAnchor:self.blurView.contentView.bottomAnchor]
    ]];
    self.vibrancyView = vibrancyView;
    [vibrancyView release];
}

- (void)setupLabel {
    UILabel *label = [UILabel new];
    label.text = @"Vibrancy!!!";
    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleLargeTitle];
    label.textColor = UIColor.secondaryLabelColor;
    
    label.backgroundColor = UIColor.purpleColor;
    label.preferredVibrancy = UILabelVibrancyNone;
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.blurView.contentView addSubview:label];
    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:self.blurView.contentView.centerXAnchor],
        [label.centerYAnchor constraintEqualToAnchor:self.blurView.contentView.centerYAnchor]
    ]];
    self.label = label;
    [label release];
}

@end
