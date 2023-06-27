//
//  DocumentViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/28/23.
//

#import "DocumentViewController.h"
#import "Document.h"

@interface DocumentViewController ()
@property (retain) UITextView *textView;
@end

@implementation DocumentViewController

- (void)dealloc {
    [_textView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UITextView *textView = [UITextView new];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textView];
    [NSLayoutConstraint activateConstraints:@[
        [textView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    self.textView = textView;
    [textView release];
}

- (void)documentDidOpen {
    [super documentDidOpen];
    self.textView.text = ((Document *)self.document).text;
}

@end
