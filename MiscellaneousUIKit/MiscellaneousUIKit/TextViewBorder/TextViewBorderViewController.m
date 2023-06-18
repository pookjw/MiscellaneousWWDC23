//
//  TextViewBorderViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/18/23.
//

#import "TextViewBorderViewController.h"

@interface TextViewBorderViewController ()
@property (retain) UITextView *textView;
@end

@implementation TextViewBorderViewController

- (void)dealloc {
    [_textView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.text = @"TEST";
    textView.backgroundColor = UIColor.systemPurpleColor;
    
    // ???????
    // I set watchpoint but it never calls
    textView.borderStyle = UITextViewBorderStyleRoundedRect;
    textView.layer.borderColor = UIColor.systemBlueColor.CGColor;
    textView.layer.borderWidth = 2.f;
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textView];
    [NSLayoutConstraint activateConstraints:@[
        [textView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [textView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [textView.widthAnchor constraintEqualToConstant:300.f],
        [textView.heightAnchor constraintEqualToConstant:300.f]
    ]];
    self.textView = textView;
    [textView release];
}

@end
