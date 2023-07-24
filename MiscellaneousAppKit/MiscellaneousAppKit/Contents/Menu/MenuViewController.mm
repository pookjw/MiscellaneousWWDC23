//
//  MenuViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/24/23.
//

#import "MenuViewController.hpp"
#import <objc/message.h>

namespace MenuViewControllerIdentifiers {
    static NSUserInterfaceItemIdentifier const helloWorldItemIdentifier = @"helloworld";
};

@interface MenuViewController ()
@property (retain) NSButton *button;
@end

@implementation MenuViewController

- (void)dealloc {
    [_button release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSButton *button = [NSButton buttonWithTitle:NSStringFromClass(NSMenu.class)
                                           image:[NSImage imageWithSystemSymbolName:@"filemenu.and.selection" accessibilityDescription:nullptr]
                                          target:self
                                          action:@selector(foo:)];
    
    //
    
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Title"];
    menu.selectionMode = NSMenuSelectionModeSelectOne;
    
    NSMenuItem *helloWorldItem = [[NSMenuItem alloc] initWithTitle:@"Hello World!"
                                                            action:@selector(foo:)
                                                     keyEquivalent:@""];
    helloWorldItem.identifier = MenuViewControllerIdentifiers::helloWorldItemIdentifier;
    helloWorldItem.target = self;
    [menu addItem:helloWorldItem];
    [helloWorldItem release];
    
    button.menu = menu;
    [menu release];
    
    //
    
    button.bezelStyle = NSBezelStyleAccessoryBar;
    [button layout];
    
    NSButtonCell *cell = static_cast<NSButtonCell *>(button.cell);
    auto buttonImageView = reinterpret_cast<__kindof NSView * (*)(NSButtonCell *, SEL)>(objc_msgSend)(cell, NSSelectorFromString(@"_buttonImageView"));
    reinterpret_cast<void (*)(__kindof NSView *, SEL, NSSymbolEffect *, NSSymbolEffectOptions *, BOOL)>(objc_msgSend)(buttonImageView, @selector(addSymbolEffect:options:animated:), [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer], [NSSymbolEffectOptions optionsWithRepeating], YES);
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [NSLayoutConstraint activateConstraints:@[
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    self.button = button;
}

- (void)foo:(id)sender {
    NSLog(@"%@", sender);
    
    if ([sender isEqual:self.button]) {
        NSButton *button = self.button;
        [button.menu popUpMenuPositioningItem:button.menu.itemArray.firstObject
                                   atLocation:NSZeroPoint
                                       inView:button];
//        reinterpret_cast<void (*)(id, SEL, id, id, id, id)>(objc_msgSend)(button.menu, NSSelectorFromString(@"_popUpContextMenu:withEvent:forView:withFont:"), button.menu, nil, sender, nil);
    }
    
    if ([sender isKindOfClass:NSMenuItem.class]) {
        auto item = static_cast<NSMenuItem *>(sender);
        
        if ([item.identifier isEqualToString:MenuViewControllerIdentifiers::helloWorldItemIdentifier]) {
            switch (item.state) {
                case NSControlStateValueOn:
                    NSLog(@"On!");
                    break;
                case NSControlStateValueOff:
                    NSLog(@"Off!");
                    break;
                case NSControlStateValueMixed:
                    NSLog(@"Mixed!");
                    break;
                default:
                    break;
            }
        }
    }
}

@end
