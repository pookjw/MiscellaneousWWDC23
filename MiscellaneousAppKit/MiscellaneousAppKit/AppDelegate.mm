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
        AppDelegateIdentifiers::progressIndicatorItemIdentifier
    ];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return @[
        AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier,
        AppDelegateIdentifiers::toggleInspectorItemIdentifier,
        AppDelegateIdentifiers::runCustomizationPaletteItemIdentifier,
        AppDelegateIdentifiers::progressIndicatorItemIdentifier
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
