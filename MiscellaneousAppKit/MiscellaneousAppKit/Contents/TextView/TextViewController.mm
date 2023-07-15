//
//  TextViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/15/23.
//

#import "TextViewController.hpp"
#import <objc/message.h>

@interface TextViewController ()
@property (retain) NSScrollView *scrollView;
@property (retain) NSTextView *textView;
@end

@implementation TextViewController

- (void)dealloc {
    [_scrollView release];
    [_textView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self.view addSubview:scrollView];
    
    NSTextView *textView = [[NSTextView alloc] initWithFrame:scrollView.bounds];
    textView.inlinePredictionType = NSTextInputTraitTypeYes;
//    [textView indicator]
    
    scrollView.documentView = textView;
    
    auto _insertionIndicator = reinterpret_cast<NSTextInsertionIndicator * (*)(NSTextView *, SEL)>(objc_msgSend)(textView, NSSelectorFromString(@"_insertionIndicator"));
    _insertionIndicator.effectsViewInserter = ^(NSView * _Nonnull view) {
        NSLog(@"Hi!!!");
    };
    _insertionIndicator.color = NSColor.systemPurpleColor;
    _insertionIndicator.displayMode = NSTextInsertionIndicatorDisplayModeHidden;
    NSLog(@"%@", _insertionIndicator);
    
    self.scrollView = scrollView;
    self.textView = textView;
    [scrollView release];
    [textView release];
}

@end
