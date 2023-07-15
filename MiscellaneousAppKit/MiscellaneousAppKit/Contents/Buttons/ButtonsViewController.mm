//
//  ButtonsViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/15/23.
//

#import "ButtonsViewController.hpp"
#import <objc/message.h>
#import <vector>
#import <algorithm>

@interface ButtonsViewController ()
@end

@implementation ButtonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    NSStackView *stackView = [[NSStackView alloc] initWithFrame:scrollView.bounds];
    stackView.alignment = NSLayoutAttributeTop;
    stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
    scrollView.documentView = stackView;
    [scrollView release];
    
    std::vector<NSBezelStyle> styles {
        NSBezelStyleAccessoryBar,
        NSBezelStyleToolbar,
        NSBezelStyleAccessoryBarAction,
        NSBezelStyleAutomatic,
        NSBezelStyleBadge,
        NSBezelStylePush,
        NSBezelStylePush,
        NSBezelStylePushDisclosure,
        NSBezelStyleDisclosure,
        NSBezelStyleCircular,
        NSBezelStyleHelpButton,
        NSBezelStyleSmallSquare
    };
    
    std::uint8_t index = 0;
    std::for_each(styles.cbegin(), styles.cend(), [stackView, &index, self](NSBezelStyle style) {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        
        NSImage * _Nullable image;
        
        switch (style) {
            case NSBezelStylePushDisclosure:
                image = nullptr;
                break;
            case NSBezelStyleDisclosure:
                image = nullptr;
                break;
            case NSBezelStyleHelpButton:
                image = nullptr;
                break;
            default:
                image = [NSImage imageWithSystemSymbolName:@"cellularbars" accessibilityDescription:nil];
                break;
        }
        
        NSButton *button;
        
        if (image) {
            button = [NSButton buttonWithTitle:[NSNumber numberWithInt:index].stringValue
                                         image:image
                                        target:self
                                        action:@selector(foo:)];
        } else {
            button = [[NSButton new] autorelease];
            button.title = @"";
        }
        
        button.bezelStyle = style;
        
        [button layout];
        
        NSButtonCell *cell = static_cast<NSButtonCell *>(button.cell);
        auto buttonImageView = reinterpret_cast<__kindof NSView * (*)(NSButtonCell *, SEL)>(objc_msgSend)(cell, NSSelectorFromString(@"_buttonImageView"));
        reinterpret_cast<void (*)(__kindof NSView *, SEL, NSSymbolEffect *, NSSymbolEffectOptions *, BOOL)>(objc_msgSend)(buttonImageView, @selector(addSymbolEffect:options:animated:), [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer], [NSSymbolEffectOptions optionsWithRepeating], YES);
        
        [stackView addView:button inGravity:NSStackViewGravityTop];
        index += 1;
        
        [pool release];
    });
    
    [stackView release];
}

- (void)foo:(NSButton *)sender {
    NSLog(@"Foo!");
}

@end
