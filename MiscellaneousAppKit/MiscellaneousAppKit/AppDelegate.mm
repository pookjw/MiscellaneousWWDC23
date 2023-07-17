//
//  AppDelegate.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import "AppDelegate.hpp"
#import "RootViewController.hpp"
#import "NSObject+Foundation_IvarDescription.h"
#import <objc/message.h>
#import <string>
#import <vector>
#import <ranges>
#import <algorithm>

@interface ToolbarItem : NSToolbarItem
@property (retain) NSMenuItem *menuFormRepresentation; // public: readonly
@end

@implementation ToolbarItem
@dynamic menuFormRepresentation;

- (NSMenuItem *)menuFormRepresentation {
    NSMenuItem *menuItem = [super menuFormRepresentation];
    menuItem.title = self.label;
    menuItem.image = self.image;
    
    return menuItem;
}

- (BOOL)allowsDuplicatesInToolbar {
    return YES;
}

@end

// TODO: NSToolbarItemGroup, NSTrackingSeparatorToolbarItem, NSSearchToolbarItem, NSMenuToolbarItem, NSUIViewToolbarItem

namespace AppDelegateIdentifiers {
static NSToolbarIdentifier const toolbarIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.toolbar";
static NSToolbarItemIdentifier const toggleInspectorItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.toggleInspectorItem";
static NSToolbarItemIdentifier const showsBaselineSeparatorItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.showsBaselineSeparator";
static NSToolbarItemIdentifier const runCustomizationPaletteItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.runCustomizationPalette";
static NSToolbarItemIdentifier const progressIndicatorItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.progressIndicator";

static NSToolbarItemIdentifier const groupItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.groupIndicator";
static NSToolbarItemIdentifier const numberOneItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.nunberOne";
static NSToolbarItemIdentifier const numberTwoItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.numberTwo";
static NSToolbarItemIdentifier const numberThreeItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.numberThree";
}

@interface AppDelegate () <NSToolbarDelegate>
@property (retain) NSWindow *window;
@end

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    RootViewController *viewController = [RootViewController new];
    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:AppDelegateIdentifiers::toolbarIdentifier];
    NSWindow *window = [NSWindow new];
    toolbar.delegate = self;
    toolbar.displayMode = NSToolbarDisplayModeIconAndLabel;
    toolbar.allowsUserCustomization = YES;
    toolbar.allowsExtensionItems = YES;
    toolbar.showsBaselineSeparator = YES; // 1px bottom line
    toolbar.centeredItemIdentifiers = [NSSet setWithObject:AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier];
    toolbar.autosavesConfiguration = YES;
//    reinterpret_cast<void (*)(id, SEL)>(objc_msgSend)(toolbar, NSSelectorFromString(@"_loadViewIfNecessary"));
    
//    auto _toolbarView = reinterpret_cast<__kindof NSView * (*)(id, SEL)>(objc_msgSend)(toolbar, NSSelectorFromString(@"_toolbarView"));
//    NSLog(@"%@", [_toolbarView _fd_ivarDescription]);
    
    window.styleMask = NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskFullSizeContentView | NSWindowStyleMaskResizable | NSWindowStyleMaskTitled;
//    window.movableByWindowBackground = YES;
    window.title = NSProcessInfo.processInfo.processName;
    window.releasedWhenClosed = NO;
//    window.titlebarAppearsTransparent = YES;
    window.toolbar = toolbar;
    window.contentViewController = viewController;
    [viewController release];
    [window makeKeyAndOrderFront:nil];
    self.window = window;
    [window release];
    [toolbar release];
}

- (void)foo:(NSToolbarItem *)sender {
    if ([sender.itemIdentifier isEqualToString:AppDelegateIdentifiers::toggleInspectorItemIdentifier]) {
        auto window = reinterpret_cast<NSWindow * (*)(id, SEL)>(objc_msgSend)(sender.toolbar, NSSelectorFromString(@"_window"));
        auto rootViewController = static_cast<RootViewController *>(window.contentViewController);
        auto splitViewController = rootViewController.splitViewController;
        [splitViewController toggleInspector:sender];
    } else if ([sender.itemIdentifier isEqualToString:AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier]) {
        sender.toolbar.showsBaselineSeparator = !sender.toolbar.showsBaselineSeparator;
    } else if ([sender.itemIdentifier isEqualToString:AppDelegateIdentifiers::runCustomizationPaletteItemIdentifier]) {
        [sender.toolbar runCustomizationPalette:sender];
    }
    
    auto _toolbarView = reinterpret_cast<__kindof NSView * (*)(id, SEL)>(objc_msgSend)(sender.toolbar, NSSelectorFromString(@"_toolbarView"));
    NSLog(@"%@", [_toolbarView _fd_ivarDescription]);
}

#pragma mark - NSToolbarDelegate

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::toggleInspectorItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"arrowshape.left.arrowshape.right.fill" accessibilityDescription:nil];
        toolbarItem.label = @"Inspector";
        
        return [toolbarItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"line.diagonal" accessibilityDescription:nil];
        toolbarItem.label = @"showsBaselineSeparator";
        toolbarItem.possibleLabels = [NSSet setWithObject:@"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"];
        
        return [toolbarItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::runCustomizationPaletteItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"paintpalette" accessibilityDescription:nil];
        toolbarItem.label = @"runCustomizationPalette";
        
        return [toolbarItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::progressIndicatorItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        
        NSProgressIndicator *indicator = [NSProgressIndicator new];
        indicator.usesThreadedAnimation = YES;
        indicator.style = NSProgressIndicatorStyleSpinning;
        indicator.indeterminate = YES;
        [indicator startAnimation:nil];
        
        toolbarItem.view = indicator;
        [indicator release];
        
        return [toolbarItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::groupItemIdentifier]) {
        auto imageNames = std::vector<std::string> {"1.circle.fill", "2.circle.fill", "3.circle.fill"} |
        std::views::transform([](const std::string value) -> NSString * {
            return [NSString stringWithCString:value.data() encoding:NSUTF8StringEncoding];
        });
        
        std::vector<NSImage *> images;
        std::transform(imageNames.begin(), imageNames.end(), std::back_inserter(images), [](NSString *value) -> NSImage * {
            return [NSImage imageWithSystemSymbolName:value accessibilityDescription:nullptr];
        });
        
        
        NSArray<NSImage *> *imagesArray = [NSArray arrayWithObjects:images.data() count:images.size()];
        
        NSToolbarItemGroup *group = [NSToolbarItemGroup groupWithItemIdentifier:itemIdentifier
                                                                         images:imagesArray
                                                                  selectionMode:NSToolbarItemGroupSelectionModeMomentary // TODO
                                                                         labels:[NSArray arrayWithObjects:std::vector<NSString *>(imageNames.begin(), imageNames.end()).data() count:imageNames.size()]
                                                                         target:self
                                                                         action:@selector(foo:)];
        
        std::uint8_t i {0};
        auto subitems = std::vector<const NSToolbarItemIdentifier> {
            AppDelegateIdentifiers::numberOneItemIdentifier,
            AppDelegateIdentifiers::numberTwoItemIdentifier,
            AppDelegateIdentifiers::numberThreeItemIdentifier
        } |
        std::views::transform([&i, &imageNames](const NSToolbarItemIdentifier itemIdentifier) -> std::pair<const NSToolbarItemIdentifier, NSString *> {
            std::pair<const NSToolbarItemIdentifier, NSString *> pair = std::make_pair(itemIdentifier, imageNames[i]);
            i++;
            return pair;
        })
        
        // TODO
        ;
        
        return group;
    } else {
        return nil;
    }
}

- (void)toolbarWillAddItem:(NSNotification *)notification {
    
}

- (void)toolbarDidRemoveItem:(NSNotification *)notification {
    
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return @[
        AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier,
        AppDelegateIdentifiers::toggleInspectorItemIdentifier,
        AppDelegateIdentifiers::runCustomizationPaletteItemIdentifier,
        AppDelegateIdentifiers::progressIndicatorItemIdentifier,
        AppDelegateIdentifiers::groupItemIdentifier
    ];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return @[
        AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier,
        AppDelegateIdentifiers::toggleInspectorItemIdentifier,
        AppDelegateIdentifiers::runCustomizationPaletteItemIdentifier,
        AppDelegateIdentifiers::progressIndicatorItemIdentifier,
        AppDelegateIdentifiers::groupItemIdentifier
    ];
}

- (NSSet<NSToolbarItemIdentifier> *)toolbarImmovableItemIdentifiers:(NSToolbar *)toolbar {
    return [NSSet setWithObjects:AppDelegateIdentifiers::progressIndicatorItemIdentifier, nil];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
    return @[];
}

- (BOOL)toolbar:(NSToolbar *)toolbar itemIdentifier:(NSToolbarItemIdentifier)itemIdentifier canBeInsertedAtIndex:(NSInteger)index {
    return YES;
}

@end
