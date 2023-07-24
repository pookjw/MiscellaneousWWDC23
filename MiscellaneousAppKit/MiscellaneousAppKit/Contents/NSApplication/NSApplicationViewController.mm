//
//  NSApplicationViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import "NSApplicationViewController.hpp"
#import <objc/message.h>

@interface NSApplicationViewController ()
@property (retain) NSButton *activateButton;
@end

@implementation NSApplicationViewController

- (void)dealloc {
    [_activateButton release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSStackView *stackView = [NSStackView new];
    
    NSButton *activateButton = [NSButton buttonWithTitle:NSStringFromSelector(@selector(activate))
                                                   image:[NSImage imageWithSystemSymbolName:@"cellularbars" accessibilityDescription:nil]
                                                  target:self
                                                  action:@selector(didClickActivateButton:)];
    
    NSButtonCell *activateCell = static_cast<NSButtonCell *>(activateButton.cell);
    
    // Load NSButtonImageView immediately
    [activateButton layout];
    
    // NSButtonImageView
    auto activate_buttonImageView = reinterpret_cast<__kindof NSView * (*)(NSButtonCell *, SEL)>(objc_msgSend)(activateCell, NSSelectorFromString(@"_buttonImageView"));
    reinterpret_cast<void (*)(__kindof NSView *, SEL, NSSymbolEffect *, NSSymbolEffectOptions *, BOOL)>(objc_msgSend)(activate_buttonImageView, @selector(addSymbolEffect:options:animated:), [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer], [NSSymbolEffectOptions optionsWithRepeating], YES);
    
    //
    
    NSButton *deactivateButton = [NSButton buttonWithTitle:NSStringFromSelector(@selector(deactivate))
                                                        target:NSApp
                                                        action:@selector(deactivate)];
    
    [stackView addView:activateButton inGravity:NSStackViewGravityCenter];
    [stackView addView:deactivateButton inGravity:NSStackViewGravityCenter];
    
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    ]];
    [stackView release];
    
    self.activateButton = activateButton;
}

- (void)didClickActivateButton:(NSButton *)sender {
//    [NSApp deactivate];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [slackApp activateWithOptions:NSApplicationActivateAllWindows];
//        NSRunningApplication *safariApp = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.Safari"].firstObject;
//        [NSRunningApplication.currentApplication activateFromApplication:safariApp options:NSApplicationActivateAllWindows];
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, static_cast<std::int64_t>(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [NSApplication.sharedApplication activateIgnoringOtherApps:YES];
        NSRunningApplication *slackApp = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.tinyspeck.slackmacgap"].firstObject;
//        NSRunningApplication *myApp = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.pookjw.MyApp"].firstObject;
        NSRunningApplication *safariApp = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.Safari"].firstObject;
        
//        BOOL r = [safariApp activateFromApplication:myApp options:NSApplicationActivateAllWindows];
        [NSApp yieldActivationToApplication:safariApp];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [slackApp activateWithOptions:NSApplicationActivateAllWindows];
            [NSRunningApplication.currentApplication activateFromApplication:safariApp options:NSApplicationActivateAllWindows];
        });
//        [NSApp activate];
//        assert(r);
        
//        [NSRunningApplication.currentApplication activateFromApplication:safariApp options:NSApplicationActivateAllWindows];
        
//        [NSApp yieldActivationToApplication:myApp];
    });
}

@end
