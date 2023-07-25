//
//  MenuViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/24/23.
//

#import "MenuViewController.hpp"
#import "AppDelegate.hpp"
#import <objc/message.h>
#import <array>
#import <ranges>
#import <algorithm>
#import <numeric>
#import <utility>
#import <string>
#import <map>
#import <objc/runtime.h>

namespace MenuViewControllerIdentifiers {
static NSUserInterfaceItemIdentifier const helloWorldItemIdentifier = @"helloworld";
static NSUserInterfaceItemIdentifier const firstItemIdentifier = @"first";

static NSUserInterfaceItemIdentifier const alertsBadgeItemIdentifier = @"NSMenuItemBadgeTypeAlerts";
static NSUserInterfaceItemIdentifier const newItemsBadgeItemIdentifier = @"NSMenuItemBadgeTypeNewItems";
static NSUserInterfaceItemIdentifier const noneBadgeItemIdentifier = @"NSMenuItemBadgeTypeNone";
static NSUserInterfaceItemIdentifier const updatesBadgeItemIdentifier = @"NSMenuItemBadgeTypeUpdates";
};

@interface MenuViewController () <NSMenuItemValidation, NSMenuDelegate>
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
    menu.autoenablesItems = YES; // NSMenuItemValidation
    menu.font = [NSFont preferredFontForTextStyle:NSFontTextStyleTitle1 options:nullptr];
    menu.delegate = self;
    menu.minimumWidth = 600.f;
    menu.presentationStyle = NSMenuPresentationStyleRegular;
    menu.selectionMode = NSMenuSelectionModeSelectOne;
    
    //
    
    NSMenuItem *helloWorldItem = [[NSMenuItem alloc] initWithTitle:@"Hello World!"
                                                            action:@selector(foo:)
                                                     keyEquivalent:@""];
    helloWorldItem.image = [NSImage imageWithSystemSymbolName:@"hand.wave" accessibilityDescription:nullptr];
    helloWorldItem.identifier = MenuViewControllerIdentifiers::helloWorldItemIdentifier;
    helloWorldItem.target = self;
    [menu addItem:helloWorldItem];
    [helloWorldItem release];
    
    [menu insertItem:NSMenuItem.separatorItem atIndex:1];
    
    //
    
    NSMenuItem *sectionHeaderItem = [NSMenuItem sectionHeaderWithTitle:@"Section Header"];
    sectionHeaderItem.image = [NSImage imageWithSystemSymbolName:@"volleyball" accessibilityDescription:nullptr];
    [menu addItem:sectionHeaderItem];
    
    //
    
    NSMenuItem *firstItem = [[NSMenuItem alloc] initWithTitle:@"First"
                                                       action:@selector(foo:)
                                                keyEquivalent:@""];
    firstItem.image = [NSImage imageWithSystemSymbolName:@"chart.bar.doc.horizontal" accessibilityDescription:nullptr];
    firstItem.onStateImage = [NSImage imageWithSystemSymbolName:@"circle" accessibilityDescription:nullptr];
    firstItem.offStateImage = [NSImage imageWithSystemSymbolName:@"x.circle" accessibilityDescription:nullptr];
    firstItem.mixedStateImage = [NSImage imageWithSystemSymbolName:@"sun.max.trianglebadge.exclamationmark" accessibilityDescription:nullptr];
    firstItem.toolTip = @"Yay!";
    firstItem.identifier = MenuViewControllerIdentifiers::firstItemIdentifier;
    firstItem.target = self;
    
    NSMutableAttributedString *firstAttributedString = [[NSMutableAttributedString alloc] initWithString:@"First"
                                                                                              attributes:@{
        NSFontAttributeName: [NSFont preferredFontForTextStyle:NSFontTextStyleTitle2 options:nullptr],
        NSForegroundColorAttributeName: NSColor.systemCyanColor
    }];
    firstItem.attributedTitle = firstAttributedString;
    [firstAttributedString release];
    
    [menu addItem:firstItem];
    [firstItem release];
    
    //
    
    [menu addItem:NSMenuItem.separatorItem];
    
    //
    
    NSMenuItem *badgeSectionHeaderItem = [NSMenuItem sectionHeaderWithTitle:@"Badges"];
    badgeSectionHeaderItem.image = [NSImage imageWithSystemSymbolName:@"skateboard.fill" accessibilityDescription:nullptr];
    [menu addItem:badgeSectionHeaderItem];
    
    auto badgeItems = std::vector<NSUserInterfaceItemIdentifier> {
        MenuViewControllerIdentifiers::alertsBadgeItemIdentifier,
        MenuViewControllerIdentifiers::newItemsBadgeItemIdentifier,
        MenuViewControllerIdentifiers::noneBadgeItemIdentifier,
        MenuViewControllerIdentifiers::updatesBadgeItemIdentifier
    } |
    std::views::transform([](NSUserInterfaceItemIdentifier itemIdentifier) -> std::pair<NSUserInterfaceItemIdentifier, NSMenuItemBadgeType> {
        NSMenuItemBadgeType badgeType;
        if ([itemIdentifier isEqualToString:MenuViewControllerIdentifiers::alertsBadgeItemIdentifier]) {
            badgeType = NSMenuItemBadgeTypeAlerts;
        } else if ([itemIdentifier isEqualToString:MenuViewControllerIdentifiers::newItemsBadgeItemIdentifier]) {
            badgeType = NSMenuItemBadgeTypeNewItems;
        } else if ([itemIdentifier isEqualToString:MenuViewControllerIdentifiers::noneBadgeItemIdentifier]) {
            badgeType = NSMenuItemBadgeTypeNone;
        } else if ([itemIdentifier isEqualToString:MenuViewControllerIdentifiers::updatesBadgeItemIdentifier]) {
            badgeType = NSMenuItemBadgeTypeUpdates;
        } else {
            badgeType = NSMenuItemBadgeTypeNone;
        }
        
        return std::make_pair(itemIdentifier, badgeType);
    });
    auto bagdeItemsVector = std::vector<std::pair<NSUserInterfaceItemIdentifier, NSMenuItemBadgeType>>(badgeItems.begin(), badgeItems.end());
    
    std::vector<std::uint8_t> badeItemIndices(badgeItems.size());
    std::iota(badeItemIndices.begin(), badeItemIndices.end(), 0); // 0~3
    
    std::for_each(badeItemIndices.cbegin(), badeItemIndices.cend(), [self, menu, bagdeItemsVector](const std::uint8_t index) {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        
        NSMenuItemBadge *badge = [[NSMenuItemBadge alloc] initWithCount:index + 100 type:bagdeItemsVector.at(index).second];
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:bagdeItemsVector.at(index).first
                                                      action:@selector(foo:)
                                               keyEquivalent:@""];
        item.badge = badge;
        [badge release];
        item.target = self;
        
        [menu addItem:item];
        [item release];
        
        [pool release];
    });
    
    //
    
    auto colors = [self colors];
    std::for_each(colors.cbegin(), colors.cend(), [menu](auto pair) {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        
        [menu addItem:NSMenuItem.separatorItem];
        
        NSString *title = [NSString stringWithCString:pair.first.data() encoding:NSUTF8StringEncoding];
        
        NSMenuItem *sectionHeaderItem = [NSMenuItem sectionHeaderWithTitle:title];
        [menu addItem:sectionHeaderItem];
        
        auto titles = pair.second |
        std::views::transform([](std::pair<std::string, NSColor *> pair) {
            return [NSString stringWithCString:pair.first.data() encoding:NSUTF8StringEncoding];
        });
        
        auto colors = pair.second |
        std::views::transform([](std::pair<std::string, NSColor *> pair) {
            return pair.second;
        });
        
        auto titlesVector = std::vector<NSString *>(titles.begin(), titles.end());
        auto colorsVector = std::vector<NSColor *>(colors.begin(), colors.end());
        
        NSMenu *paletteMenu = [NSMenu paletteMenuWithColors:[NSArray arrayWithObjects:colorsVector.data() count:colorsVector.size()]
                                                     titles:[NSArray arrayWithObjects:titlesVector.data() count:titlesVector.size()]
                                              templateImage:[NSImage imageWithSystemSymbolName:@"star.fill" accessibilityDescription:nullptr]
                                           selectionHandler:^(NSMenu * _Nonnull menu) {
            
        }];
        
        paletteMenu.selectionMode = NSMenuSelectionModeSelectAny;
        
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:title
                                                      action:@selector(foo:)
                                               keyEquivalent:@""];
        item.submenu = paletteMenu;
        
        [menu addItem:item];
        [item release];
        
        [pool release];
    });
    
    //
    
    [menu addItem:NSMenuItem.separatorItem];
    
    NSMenuItem *privatePaletteSectionHeaderItem = [NSMenuItem sectionHeaderWithTitle:@"Private Palette"];
    [menu addItem:privatePaletteSectionHeaderItem];
    
    NSMenu *privatePaletteMenu = [NSMenu paletteMenuWithColors:@[]
                                                        titles:@[]
                                              selectionHandler:^(NSMenu * _Nonnull) {
        
    }];
    
    const std::map<NSColor *, std::pair<NSImage *, NSSymbolEffect *>> colorAndImages {
        {NSColor.cyanColor, std::make_pair<NSImage *, NSSymbolEffect *>([NSImage imageWithSystemSymbolName:@"star.square" accessibilityDescription:nullptr], [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer])},
        {NSColor.purpleColor, std::make_pair<NSImage *, NSSymbolEffect *>([NSImage imageWithSystemSymbolName:@"square.and.arrow.up.trianglebadge.exclamationmark" accessibilityDescription:nullptr], [[NSSymbolPulseEffect effect] effectWithWholeSymbol])},
        {NSColor.yellowColor, std::make_pair<NSImage *, NSSymbolEffect *>([NSImage imageWithSystemSymbolName:@"pencil.tip.crop.circle.badge.plus.fill" accessibilityDescription:nullptr], [[NSSymbolBounceEffect bounceUpEffect] effectWithWholeSymbol])},
        {NSColor.orangeColor, std::make_pair<NSImage *, NSSymbolEffect *>([NSImage imageWithSystemSymbolName:@"newspaper" accessibilityDescription:nullptr], [[NSSymbolVariableColorEffect effect] effectWithReversing])},
        {NSColor.greenColor, std::make_pair<NSImage *, NSSymbolEffect *>([NSImage imageWithSystemSymbolName:@"medal" accessibilityDescription:nullptr], [[NSSymbolScaleEffect scaleUpEffect] effectWithWholeSymbol])}
    };
    
    std::for_each(colorAndImages.begin(), colorAndImages.end(), [privatePaletteMenu](std::pair<NSColor *, std::pair<NSImage *, NSSymbolEffect *>> pair) {
        NSAutoreleasePool *pool = [NSAutoreleasePool new];
        
        // NSPaletteMenuItem
        auto item = reinterpret_cast<__kindof NSMenuItem * (*)(id, SEL, id, id, id)>(objc_msgSend)([NSClassFromString(@"NSPaletteMenuItem") alloc], NSSelectorFromString(@"initWithColor:image:title:"), pair.first, pair.second.first, nullptr);
        
        objc_setAssociatedObject(item, NSPaletteMenuItemView_associationKey(), pair.second.second, OBJC_ASSOCIATION_COPY);
        
        [privatePaletteMenu addItem:item];
        [item release];
        
        [pool release];
    });
    
    NSMenuItem *privatePalleteMenuItem = [[NSMenuItem alloc] initWithTitle:privatePaletteSectionHeaderItem.title
                                                                    action:@selector(foo:)
                                                             keyEquivalent:@""];
    privatePalleteMenuItem.submenu = privatePaletteMenu;
    
    [menu addItem:privatePalleteMenuItem];
    [privatePalleteMenuItem release];
    
    //
    
    button.menu = menu;
    [menu release];
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
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (std::uint64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"He");
//            [button.menu cancelTrackingWithoutAnimation];
//        });
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

#pragma mark - Colors

- (std::vector<std::pair<std::string, std::vector<std::pair<std::string, NSColor *>>>>)colors {
    return {
        std::make_pair("Label Colors", [self labelColors]),
        std::make_pair("Text Colors", [self textColors]),
        std::make_pair("Content Colors", [self contentColors]),
        std::make_pair("Menu Colors", [self menuColors]),
        std::make_pair("Table Colors", [self tableColors]),
        std::make_pair("Control Colors", [self controlColors]),
        std::make_pair("Window Colors", [self windowColors]),
        std::make_pair("Highlights and Shadows", [self highlightAndShadowColors]),
        std::make_pair("Fill Colors", [self fillColors]),
        std::make_pair("Adaptable System Colors", [self adaptableSystemColors]),
        std::make_pair("Fixed Colors", [self fixedColors])
    };
}

- (std::vector<std::pair<std::string, NSColor *>>)labelColors {
    std::vector<std::string> names {
        "labelColor",
        "secondaryLabelColor",
        "tertiaryLabelColor",
        "quaternaryLabelColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)textColors {
    std::vector<std::string> names {
        "textColor",
        "placeholderTextColor",
        "selectedTextColor",
        "textBackgroundColor",
        "selectedTextBackgroundColor",
        "keyboardFocusIndicatorColor",
        "unemphasizedSelectedTextColor",
        "unemphasizedSelectedTextBackgroundColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)contentColors {
    std::vector<std::string> names {
        "linkColor",
        "separatorColor",
        "selectedContentBackgroundColor",
        "unemphasizedSelectedContentBackgroundColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)menuColors {
    std::vector<std::string> names {
        "selectedMenuItemTextColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)tableColors {
    std::vector<std::string> names {
        "gridColor",
        "headerTextColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    __block auto colors = std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
    
    [NSColor.alternatingContentBackgroundColors enumerateObjectsUsingBlock:^(NSColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        colors.push_back(std::make_pair(std::to_string(idx), obj));
    }];
    
    return colors;
}

- (std::vector<std::pair<std::string, NSColor *>>)controlColors {
    std::vector<std::string> names {
        "controlAccentColor",
        "controlColor",
        "controlBackgroundColor",
        "controlTextColor",
        "disabledControlTextColor",
        "selectedControlColor",
        "selectedControlTextColor",
        "alternateSelectedControlTextColor",
        "scrubberTexturedBackgroundColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)windowColors {
    std::vector<std::string> names {
        "windowBackgroundColor",
        "windowFrameTextColor",
        "underPageBackgroundColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)highlightAndShadowColors {
    std::vector<std::string> names {
        "findHighlightColor",
        "highlightColor",
        "shadowColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)fillColors {
    std::vector<std::string> names {
        "quaternarySystemFillColor",
        "quinaryLabelColor",
        "quinarySystemFillColor",
        "secondarySystemFillColor",
        "systemFillColor",
        "tertiarySystemFillColor",
        "textInsertionPointColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)adaptableSystemColors {
    std::vector<std::string> names {
        "systemBlueColor",
        "systemBrownColor",
        "systemCyanColor",
        "systemGrayColor",
        "systemGreenColor",
        "systemIndigoColor",
        "systemMintColor",
        "systemOrangeColor",
        "systemPinkColor",
        "systemPurpleColor",
        "systemRedColor",
        "systemTealColor",
        "systemYellowColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

- (std::vector<std::pair<std::string, NSColor *>>)fixedColors {
    std::vector<std::string> names {
        "blackColor",
        "blueColor",
        "brownColor",
        "cyanColor",
        "darkGrayColor",
        "grayColor",
        "greenColor",
        "lightGrayColor",
        "magentaColor",
        "orangeColor",
        "purpleColor",
        "redColor",
        "whiteColor",
        "yellowColor"
    };
    
    auto pairs = names |
    std::views::transform([](std::string name) {
        auto color = reinterpret_cast<NSColor * (*)(Class, SEL)>(objc_msgSend)(NSColor.class, sel_registerName(name.data()));
        return std::make_pair(name, [[color retain] autorelease]);
    });
    
    return std::vector<std::pair<std::string, NSColor *>>(pairs.begin(), pairs.end());
}

#pragma mark - NSMenuItemValidation

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    return ![menuItem.identifier isEqualToString:MenuViewControllerIdentifiers::helloWorldItemIdentifier];
}

#pragma mark - NSMenuDelegate

- (BOOL)menuHasKeyEquivalent:(NSMenu *)menu forEvent:(NSEvent *)event target:(id  _Nullable *)target action:(SEL  _Nullable *)action {
    return YES;
}

@end
