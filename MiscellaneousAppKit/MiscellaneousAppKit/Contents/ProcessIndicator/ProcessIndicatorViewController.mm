//
//  ProcessIndicatorViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/15/23.
//

#import "ProcessIndicatorViewController.hpp"
#import <objc/message.h>

@interface ProcessIndicatorViewController () <NSTextFieldDelegate>
@property (retain) NSProgress *progress;
@property (retain) NSStackView *stackView;
@property (retain) NSProgressIndicator *indicator;
@property (retain) NSProgressIndicator *indicator_4;
@property (retain) NSButton *button;
@end

@implementation ProcessIndicatorViewController

- (void)dealloc {
    [_progress release];
    [_stackView release];
    [_indicator release];
    [_indicator_4 release];
    [_button release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSProgress *progress = [NSProgress new];
    progress.totalUnitCount = 10;
    progress.completedUnitCount = 0;
    self.progress = progress;
    
    NSStackView *stackView = [[NSStackView alloc] initWithFrame:self.view.bounds];
    stackView.alignment = NSLayoutAttributeCenterX;
    stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    self.stackView = stackView;
    
    //
    
    NSProgressIndicator *indicator = [NSProgressIndicator new];
    indicator.usesThreadedAnimation = YES;
    indicator.controlSize = NSControlSizeLarge;
    indicator.style = NSProgressIndicatorStyleBar;
    indicator.indeterminate = NO;
    indicator.observedProgress = progress;
    
    [indicator startAnimation:self];
    [stackView addView:indicator inGravity:NSStackViewGravityTop];
    self.indicator = indicator;
    [indicator release];
    
    //
    
    NSProgressIndicator *indicator_2 = [NSProgressIndicator new];
    indicator_2.usesThreadedAnimation = YES;
    indicator_2.style = NSProgressIndicatorStyleBar;
    indicator_2.indeterminate = YES;
    
    [indicator_2 startAnimation:self];
    [stackView addView:indicator_2 inGravity:NSStackViewGravityTop];
    [indicator_2 release];
    
    //
    
    NSProgressIndicator *indicator_3 = [NSProgressIndicator new];
    indicator_3.usesThreadedAnimation = YES;
    indicator_3.style = NSProgressIndicatorStyleSpinning;
    indicator_3.indeterminate = YES;
    
    [indicator_3 startAnimation:self];
    [stackView addView:indicator_3 inGravity:NSStackViewGravityTop];
    [indicator_3 release];
    
    //
    
    NSProgressIndicator *indicator_4 = [NSProgressIndicator new];
    indicator_4.usesThreadedAnimation = YES;
    indicator_4.style = NSProgressIndicatorStyleSpinning;
    indicator_4.indeterminate = NO;
    indicator_4.observedProgress = progress;
    
    [indicator_4 startAnimation:self];
    [stackView addView:indicator_4 inGravity:NSStackViewGravityTop];
    [indicator_4 release];
    
    //
    
    NSButton *button = [NSButton buttonWithTitle:@"Increment!"
                                           image:[NSImage imageWithSystemSymbolName:@"arrow.up.doc.on.clipboard" accessibilityDescription:nil]
                                          target:self
                                          action:@selector(foo:)];
    button.bezelStyle = NSBezelStyleAccessoryBar;
    [button layout];
    
    NSButtonCell *cell = static_cast<NSButtonCell *>(button.cell);
    auto buttonImageView = reinterpret_cast<__kindof NSView * (*)(NSButtonCell *, SEL)>(objc_msgSend)(cell, NSSelectorFromString(@"_buttonImageView"));
    reinterpret_cast<void (*)(__kindof NSView *, SEL, NSSymbolEffect *, NSSymbolEffectOptions *, BOOL)>(objc_msgSend)(buttonImageView, @selector(addSymbolEffect:options:animated:), [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer], [NSSymbolEffectOptions optionsWithRepeating], YES);
    
    [stackView addView:button inGravity:NSStackViewGravityTop];
    
    //
    
    [progress release];
    [stackView release];
}

- (void)foo:(NSButton *)sender {
    self.progress.completedUnitCount += 1;
}

@end
