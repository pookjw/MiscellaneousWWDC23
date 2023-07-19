//
//  PresentViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/16/23.
//

#import "PresentViewController.hpp"
#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import <string>
#import <vector>
#import <ranges>

namespace ViewControllerWindowBlurTransition {
const std::string blurViewKeyName = "_blurViewKey";
std::uint8_t *blurViewKey(id self) {
    std::uint8_t *blurViewKey = nullptr;
    object_getInstanceVariable(self, blurViewKeyName.data(), reinterpret_cast<void **>(&blurViewKey));
    
    if (blurViewKey == nullptr) {
        blurViewKey = new std::uint8_t;
        object_setInstanceVariable(self, blurViewKeyName.data(), blurViewKey);
    }
    
    return blurViewKey;
}
void setBlurView(id self, id target, NSVisualEffectView * _Nullable blurView) {
    objc_setAssociatedObject(target, blurViewKey(self), blurView, OBJC_ASSOCIATION_RETAIN);
}
NSVisualEffectView * _Nullable blurView(id self, id target) {
    return objc_getAssociatedObject(target, blurViewKey(self));
}

void dealloc(id self, SEL _cmd) {
    delete blurViewKey(self);
    struct objc_super superInfo = { self, [self superclass] };
    reinterpret_cast<void (*)(struct objc_super *, SEL)>(objc_msgSendSuper)(&superInfo, _cmd);
}

NSWindow * _makeWindowWithContentRect(id<NSViewControllerPresentationAnimator> animator, SEL _cmd, struct CGRect contentRect) {
    struct objc_super superInfo = { animator, animator.superclass };
    auto window = reinterpret_cast<NSWindow * (*)(struct objc_super *, SEL, struct CGRect)>(objc_msgSendSuper)(&superInfo, _cmd, contentRect);
    
    // NSViewControllerModalWindowTransition uses this behavior
    window.animationBehavior = NSWindowAnimationBehaviorAlertPanel;
    
    return window;
}

void animatePresentationOfViewController_fromViewController(id<NSViewControllerPresentationAnimator> animator, SEL _cmd, NSViewController *viewController, NSViewController *fromViewController) {
    struct objc_super superInfo = { animator, animator.superclass };
    reinterpret_cast<void (*)(struct objc_super *, SEL, id, id)>(objc_msgSendSuper)(&superInfo, _cmd, viewController, fromViewController);
    
    auto window = reinterpret_cast<NSWindow * (*)(id, SEL)>(objc_msgSend)(animator, NSSelectorFromString(@"window"));
    
    NSVisualEffectView *blurView = [[NSVisualEffectView alloc] initWithFrame:fromViewController.view.bounds];
    blurView.material = NSVisualEffectMaterialSidebar;
    blurView.emphasized = YES;
    blurView.state = NSVisualEffectStateActive;
    blurView.blendingMode = NSVisualEffectBlendingModeWithinWindow;
//    blurView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // NSThemeFrame
    auto _themeFrame = reinterpret_cast<__kindof NSView * (*)(id, SEL)>(objc_msgSend)(fromViewController.view.window, NSSelectorFromString(@"_themeFrame"));
    [_themeFrame addSubview:blurView];
    [NSLayoutConstraint activateConstraints:@[
        [blurView.topAnchor constraintEqualToAnchor:_themeFrame.topAnchor],
        [blurView.leadingAnchor constraintEqualToAnchor:_themeFrame.leadingAnchor],
        [blurView.trailingAnchor constraintEqualToAnchor:_themeFrame.trailingAnchor],
        [blurView.bottomAnchor constraintEqualToAnchor:_themeFrame.bottomAnchor],
    ]];
    setBlurView(animator, fromViewController.view.window, blurView);
    [blurView release];
    
    blurView.alphaValue = 0.f;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.3f;
        blurView.animator.alphaValue = 1.f;
    } completionHandler:^{
        blurView.alphaValue = 1.f;
        [NSApp runModalForWindow:window];
    }];
}

void animateDismissalOfViewController_fromViewController(id<NSViewControllerPresentationAnimator> animator, SEL _cmd, NSViewController *viewController, NSViewController *fromViewController) {
    [NSApp stopModal];
    
    NSVisualEffectView * _Nullable _blurView = blurView(animator, fromViewController.view.window);
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext * _Nonnull context) {
        context.duration = 0.3f;
        _blurView.animator.alphaValue = 0.f;
    } completionHandler:^{
        [_blurView removeFromSuperview];
    }];
    
    setBlurView(animator, fromViewController.view.window, nil);
    
    struct objc_super superInfo = { animator, animator.superclass };
    reinterpret_cast<void (*)(struct objc_super *, SEL, id, id)>(objc_msgSendSuper)(&superInfo, _cmd, viewController, fromViewController);
}

Class _Nullable _isa = nullptr;
Class getIsa() {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _isa = objc_allocateClassPair(NSClassFromString(@"NSViewControllerWindowTransition"), "ViewControllerWindowBlurTransition", 0);
        class_addIvar(_isa, blurViewKeyName.data(), sizeof(std::shared_ptr<std::uint8_t>), rint(log2(sizeof(std::shared_ptr<std::uint8_t>))), @encode(std::shared_ptr<std::uint8_t>));
        class_addMethod(_isa, @selector(dealloc), reinterpret_cast<IMP>(dealloc), nullptr);
        class_addMethod(_isa, NSSelectorFromString(@"_makeWindowWithContentRect:"), reinterpret_cast<IMP>(_makeWindowWithContentRect), nullptr);
        class_addMethod(_isa, @selector(animatePresentationOfViewController:fromViewController:), reinterpret_cast<IMP>(animatePresentationOfViewController_fromViewController), nullptr);
        class_addMethod(_isa, @selector(animateDismissalOfViewController:fromViewController:), reinterpret_cast<IMP>(animateDismissalOfViewController_fromViewController), nullptr);
    });
    
    return _isa;
}
}

@interface PresentViewController ()
@property (assign) std::vector<NSButton *> buttons;
@end

@implementation PresentViewController

- (void)dealloc {
    auto buttons = _buttons;
    std::for_each(buttons.cbegin(), buttons.cend(), [](const NSButton * button) {
        [button release];
    });
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.systemGreenColor.CGColor;
    
    //
    
    NSStackView *stackView = [NSStackView new];
    stackView.alignment = NSLayoutAttributeLeading;
    stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackView];
    [NSLayoutConstraint activateConstraints:@[
        [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    //
    
    auto buttons = std::vector<std::string> {
        sel_getName(@selector(presentViewController:animator:)),
        sel_getName(@selector(presentViewController:asPopoverRelativeToRect:ofView:preferredEdge:behavior:)),
        sel_getName(@selector(presentViewController:asPopoverRelativeToRect:ofView:preferredEdge:behavior:hasFullSizeContent:)), // NEW
        sel_getName(@selector(presentViewControllerAsModalWindow:)), // NSViewControllerModalWindowTransition -> presentViewController:animator:
        sel_getName(@selector(presentViewControllerAsSheet:)),
//        "presentViewControllerInWidget:" // deprecated
    } |
    std::views::transform([self, stackView](std::string selector) -> NSButton * {
        auto button = [NSButton buttonWithTitle:[NSString stringWithUTF8String:selector.data()] target:self action:@selector(foo:)];
        [stackView addView:button inGravity:NSStackViewGravityLeading];
        return [button retain];
    });
    
    self.buttons = std::vector<NSButton *>(buttons.begin(), buttons.end());
    
    //
    
    [stackView release];
}

- (void)foo:(NSButton *)sender {
    NSViewController *dismissableViewController = [self newDismissableViewController];
    SEL senderSelector = sel_registerName(sender.title.UTF8String);
    
    if (sel_isEqual(senderSelector, @selector(presentViewController:animator:))) {
        //        id<NSViewControllerPresentationAnimator> animator = reinterpret_cast<id (*)(Class, SEL)>(objc_msgSend)(NSClassFromString(@"NSViewControllerWindowTransition"), @selector(new));
        id<NSViewControllerPresentationAnimator> animator = [ViewControllerWindowBlurTransition::getIsa() new];
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(animator, NSSelectorFromString(@"setFromViewController:"), self);
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(animator, NSSelectorFromString(@"setToViewController:"), dismissableViewController);
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(animator, NSSelectorFromString(@"setCompletionHandler:"), ^{
            
        });
        
        [self presentViewController:dismissableViewController animator:animator];
        [animator release];
    } else if (sel_isEqual(senderSelector, @selector(presentViewController:asPopoverRelativeToRect:ofView:preferredEdge:behavior:))) {
        // NSViewControllerPopoverTransition
        [self presentViewController:dismissableViewController
            asPopoverRelativeToRect:sender.bounds
                             ofView:sender
                      preferredEdge:NSRectEdgeMaxX
                           behavior:NSPopoverBehaviorSemitransient];
    } else if (sel_isEqual(senderSelector, @selector(presentViewController:asPopoverRelativeToRect:ofView:preferredEdge:behavior:hasFullSizeContent:))) {
        // NSViewControllerPopoverTransition
        [self presentViewController:dismissableViewController
            asPopoverRelativeToRect:sender.bounds
                             ofView:sender
                      preferredEdge:NSRectEdgeMaxX
                           behavior:NSPopoverBehaviorTransient
                 hasFullSizeContent:YES];
    } else if (sel_isEqual(senderSelector, @selector(presentViewControllerAsModalWindow:))) {
        // NSViewControllerModalWindowTransition
        [self presentViewControllerAsModalWindow:dismissableViewController];
    } else if (sel_isEqual(senderSelector, @selector(presentViewControllerAsSheet:))) {
        // NSViewControllerSheetTransition
        [self presentViewControllerAsSheet:dismissableViewController];
    } else if (strcmp(sel_getName(senderSelector), "presentViewControllerInWidget:") == 0) {
        //        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(self, NSSelectorFromString(@"presentViewControllerInWidget:"), dismissableViewController);
    }
    
    [dismissableViewController release];
}

- (NSViewController *)newDismissableViewController NS_RETURNS_RETAINED {
    NSViewController *dismissableViewController = [NSViewController new];
    
    NSButton *dismissButton = [NSButton buttonWithTitle:@"Dismiss" target:self action:@selector(foo2:)];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    [dismissableViewController.view addSubview:dismissButton];
    [NSLayoutConstraint activateConstraints:@[
        [dismissButton.centerXAnchor constraintEqualToAnchor:dismissableViewController.view.centerXAnchor],
        [dismissButton.centerYAnchor constraintEqualToAnchor:dismissableViewController.view.centerYAnchor]
    ]];
    
    NSView *purpleView = [NSView new];
    purpleView.wantsLayer = YES;
    purpleView.layer.backgroundColor = NSColor.purpleColor.CGColor;
    purpleView.translatesAutoresizingMaskIntoConstraints = NO;
    [dismissableViewController.view addSubview:purpleView];
    [NSLayoutConstraint activateConstraints:@[
        [purpleView.topAnchor constraintEqualToAnchor:dismissableViewController.view.topAnchor],
        [purpleView.bottomAnchor constraintEqualToAnchor:dismissableViewController.view.bottomAnchor],
        [purpleView.leadingAnchor constraintEqualToAnchor:dismissableViewController.view.leadingAnchor],
        [purpleView.trailingAnchor constraintEqualToAnchor:dismissableViewController.view.safeAreaLayoutGuide.leadingAnchor],
    ]];
    [purpleView release];
    
    return dismissableViewController;
}

- (void)foo2:(NSButton *)sender {
    [self dismissViewController:self.presentedViewControllers.firstObject];
}

@end
