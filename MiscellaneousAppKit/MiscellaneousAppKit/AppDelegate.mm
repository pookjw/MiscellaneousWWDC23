//
//  AppDelegate.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/14/23.
//

#import "AppDelegate.hpp"
#import "RootViewController.hpp"
#import "NSObject+Foundation_IvarDescription.h"
#import "NSPaletteMenuItem+copyWithZone.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import <string>
#import <vector>
#import <ranges>
#import <algorithm>
#import <dlfcn.h>

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

@interface MenuToolbarItem : NSMenuToolbarItem
@end
@implementation MenuToolbarItem

- (NSMenuItem *)menuFormRepresentation {
    NSMenuItem *item = [super menuFormRepresentation];
    item.title = self.title;
    item.image = self.image;
    return item;
}
@end

// TODO: NSMenuToolbarItem, NSUIViewToolbarItem

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

static NSToolbarItemIdentifier const trackingSeparatorItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.trackingSeparator";
static NSToolbarItemIdentifier const leftNavigationalItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.leftNavigational";
static NSToolbarItemIdentifier const rightNavigationalItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.rightNavigational";

static NSToolbarItemIdentifier const popoverItemIdentifier = @"com.pookjw.MiscellaneousAppKit.AppDelegate.popover";

static NSToolbarItemIdentifier const searchItemIdentifier = @"com.pookjw.MiscellaneousAppKit.search";
static NSSearchFieldRecentsAutosaveName const searchFieldRecentsAutosaveName = @"com.pookjw.MiscellaneousAppKit.searchRecents";

static NSToolbarItemIdentifier const menuToolbarItemIdentifier = @"com.pookjw.MiscellaneousAppKit.menuToolbar";
}

namespace NSMenuItemView {
namespace _applyImage_withImageSize {
static void (*original)(id, SEL, NSImage *, struct CGSize);
static void custom(id self, SEL _cmd, NSImage *image, struct CGSize imageSize) {
    original(self, _cmd, image, imageSize);
    
    NSImageView * _Nullable imageView = nullptr;
    object_getInstanceVariable(self, "_imageView", reinterpret_cast<void **>(&imageView));
    
    if (imageView) {
        [imageView addSymbolEffect:[[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer] options:[NSSymbolEffectOptions optionsWithRepeating] animated:YES];
    }
}
}
}

namespace NSPaletteMenuItemView {
namespace layout {
static std::uint8_t *associationKey;
static void (*original)(id, SEL);
static void custom(id self, SEL _cmd) {
    original(self, _cmd);
    
    auto menuItem = reinterpret_cast<NSMenuItem * _Nullable (*)(id, SEL)>(objc_msgSend)(self, @selector(menuItem));
    NSSymbolEffect *effect = objc_getAssociatedObject(menuItem, associationKey);
    
    if (effect) {
        [static_cast<__kindof NSView *>(self).subviews enumerateObjectsUsingBlock:^(__kindof NSView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSImageView.class]) {
                auto imageView = static_cast<NSImageView *>(obj);
                [imageView addSymbolEffect:effect options:[NSSymbolEffectOptions optionsWithRepeating] animated:YES];
            }
        }];
    }
}
}
}

const std::uint8_t * NSPaletteMenuItemView_associationKey() {
    return NSPaletteMenuItemView::layout::associationKey;
}

@interface AppDelegate () <NSToolbarDelegate, NSSearchFieldDelegate>
@property (retain) NSWindow *window;
@end

@implementation AppDelegate

+ (void)load {
    registerNSPaletteMenuItemCopyMethod();
    
    Method method_1 = class_getInstanceMethod(NSClassFromString(@"NSMenuItemView"), NSSelectorFromString(@"_applyImage:withImageSize:"));
    NSMenuItemView::_applyImage_withImageSize::original = reinterpret_cast<void (*)(id, SEL, NSImage *, struct CGSize)>(method_getImplementation(method_1));
    method_setImplementation(method_1, reinterpret_cast<IMP>(NSMenuItemView::_applyImage_withImageSize::custom));
    
    Method method_2 = class_getInstanceMethod(NSClassFromString(@"NSPaletteMenuItemView"), @selector(layout));
    NSPaletteMenuItemView::layout::original = reinterpret_cast<void (*)(id, SEL)>(method_getImplementation(method_2));
    method_setImplementation(method_2, reinterpret_cast<IMP>(NSPaletteMenuItemView::layout::custom));
}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSPaletteMenuItemView::layout::associationKey = new std::uint8_t;
    
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
    } else if ([sender.itemIdentifier isEqualToString:AppDelegateIdentifiers::groupItemIdentifier]) {
        auto group = static_cast<NSToolbarItemGroup *>(sender);
        auto selectedItem = group.subitems[group.selectedIndex];
        auto selectedItemIdentifier = selectedItem.itemIdentifier;
        
        group.title = @(group.selectedIndex).stringValue;
    } else if ([sender.itemIdentifier isEqualToString:AppDelegateIdentifiers::popoverItemIdentifier]) {
        NSPopover *popover = [NSPopover new];
        NSViewController *contentViewController = [NSViewController new];
        popover.contentViewController = contentViewController;
        [contentViewController release];
        popover.behavior = NSPopoverBehaviorSemitransient;
        popover.animates = YES;
        popover.contentSize = NSMakeSize(400.f, 400.f);
        [popover showRelativeToToolbarItem:sender];
        
        [popover release];
    }

//    auto _toolbarView = reinterpret_cast<__kindof NSView * (*)(id, SEL)>(objc_msgSend)(sender.toolbar, NSSelectorFromString(@"_toolbarView"));
//    NSLog(@"%@", [_toolbarView _fd_ivarDescription]);
}

- (void)searchFieldFoo:(NSSearchField *)sender {
    NSLog(@"%@", sender.stringValue);
}

#pragma mark - NSToolbarDelegate

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::toggleInspectorItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"arrowshape.left.arrowshape.right.fill" accessibilityDescription:nil];
        toolbarItem.label = @"Inspector";
        
        // NSToolbarButton (NSButton)
        auto _view = reinterpret_cast<NSButton * (*)(id, SEL)>(objc_msgSend)(toolbarItem, NSSelectorFromString(@"_view"));
        
        // _NSToolbarButtonCell
        NSButtonCell *cell = static_cast<NSButtonCell *>(_view.cell);
        // Avoid NSIsEmptyRect
        reinterpret_cast<void (*)(id, SEL, struct CGRect, id)>(objc_msgSend)(cell, NSSelectorFromString(@"_updateImageViewWithFrame:inView:"), CGRectMake(0.f, 0.f, 1.f, 1.f), _view);

        auto buttonImageView = reinterpret_cast<__kindof NSView * (*)(NSButtonCell *, SEL)>(objc_msgSend)(cell, NSSelectorFromString(@"_buttonImageView"));
        reinterpret_cast<void (*)(__kindof NSView *, SEL, NSSymbolEffect *, NSSymbolEffectOptions *, BOOL)>(objc_msgSend)(buttonImageView, @selector(addSymbolEffect:options:animated:), [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer], [NSSymbolEffectOptions optionsWithRepeating], YES);
        
        return [toolbarItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"line.diagonal" accessibilityDescription:nil];
        toolbarItem.label = @"showsBaselineSeparator";
//        toolbarItem.possibleLabels = [NSSet setWithObject:@"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"];
        
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
                                                                  selectionMode:NSToolbarItemGroupSelectionModeSelectAny
                                                                         labels:[NSArray arrayWithObjects:std::vector<NSString *>(imageNames.begin(), imageNames.end()).data() count:imageNames.size()]
                                                                         target:self
                                                                         action:@selector(foo:)];
        
        group.title = @"TEST"; // will presented when NSToolbarItemGroupControlRepresentationCollapsed
        group.controlRepresentation = NSToolbarItemGroupControlRepresentationCollapsed;
        
        std::uint8_t i {0};
        auto subitems = std::vector<const NSToolbarItemIdentifier> {
            AppDelegateIdentifiers::numberOneItemIdentifier,
            AppDelegateIdentifiers::numberTwoItemIdentifier,
            AppDelegateIdentifiers::numberThreeItemIdentifier
        } |
        std::views::transform([&i, &images](const NSToolbarItemIdentifier itemIdentifier) -> std::pair<const NSToolbarItemIdentifier, NSImage *> {
            std::pair<const NSToolbarItemIdentifier, NSImage *> pair = std::make_pair(itemIdentifier, images[i]);
            i++;
            return pair;
        }) |
        std::views::transform([self](std::pair<const NSToolbarItemIdentifier, NSImage *> pair) {
            ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:pair.first];
            
            // only invoked when menu style (collapsed)
            toolbarItem.target = self;
            toolbarItem.action = @selector(foo:);
            
            // Will Override NSToolbarItemGroup's labels
            toolbarItem.label = [pair.first componentsSeparatedByString:@"."].lastObject;
            
            //            toolbarItem.image = pair.second;
            
            // Ignored when using NSToolbarItemGroup
            toolbarItem.image = [NSImage imageWithSystemSymbolName:@"square.and.arrow.up.circle.fill" accessibilityDescription:nil];
            
            return [toolbarItem autorelease];
        });
        
        // If you comment this, NSToolbarItemGroup will create Items at initializer.
        //        group.subitems = [NSArray arrayWithObjects:std::vector<ToolbarItem *>(subitems.begin(), subitems.end()).data() count:subitems.size()];
        
        return group;
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::trackingSeparatorItemIdentifier]) {
        auto window = reinterpret_cast<NSWindow * (*)(id, SEL)>(objc_msgSend)(toolbar, NSSelectorFromString(@"_window"));
        auto rootViewController = static_cast<RootViewController *>(window.contentViewController);
        auto splitViewController = rootViewController.splitViewController;
        
        NSTrackingSeparatorToolbarItem *toolbarItem = [NSTrackingSeparatorToolbarItem trackingSeparatorToolbarItemWithIdentifier:itemIdentifier splitView:splitViewController.splitView dividerIndex:1];
        
        return toolbarItem;
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::leftNavigationalItemIdentifier]) {
        NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        item.target = self;
        item.action = @selector(foo:);
        item.image = [NSImage imageWithSystemSymbolName:@"chevron.left" accessibilityDescription:nil];
        item.navigational = YES;
        
        return [item autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::rightNavigationalItemIdentifier]) {
        NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        item.target = self;
        item.action = @selector(foo:);
        item.image = [NSImage imageWithSystemSymbolName:@"chevron.right" accessibilityDescription:nil];
        item.navigational = YES;
        
        return [item autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::popoverItemIdentifier]) {
        ToolbarItem *toolbarItem = [[ToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.target = self;
        toolbarItem.action = @selector(foo:);
        toolbarItem.label = @"Popover";
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"rectangle.portrait.and.arrow.right" accessibilityDescription:nil];
        
        return [toolbarItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::searchItemIdentifier]) {
        NSSearchToolbarItem *searchItem = [[NSSearchToolbarItem alloc] initWithItemIdentifier:AppDelegateIdentifiers::searchItemIdentifier];
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(searchItem, NSSelectorFromString(@"setPlaceholderString:"), @"Pl🎃ceholder");
        searchItem.preferredWidthForSearchField = 200.f;
        searchItem.resignsFirstResponderWithCancel = NO;
        
        NSSearchField *searchField = searchItem.searchField;
        searchField.delegate = self;
        
        // delay를 가질지 말지
        searchField.sendsSearchStringImmediately = YES;
        
        // 엔터 및 캔슬할 때만 이벤트 보내기
        searchField.sendsWholeSearchString = NO;
        
        searchField.recentsAutosaveName = AppDelegateIdentifiers::searchFieldRecentsAutosaveName;
        searchField.maximumRecents = 10;
        
        NSMenu *searchMenu = [[NSMenu alloc] initWithTitle:@"Menu"];
        
        NSMenuItem *recentsTitleMenuItem = [[NSMenuItem alloc] initWithTitle:@"Recents" action:nullptr keyEquivalent:@""];
        recentsTitleMenuItem.tag = NSSearchFieldRecentsTitleMenuItemTag;
        
        NSMenuItem *recentsMenuItem = [[NSMenuItem alloc] initWithTitle:@"Recents" action:nullptr keyEquivalent:@""];
        recentsMenuItem.tag = NSSearchFieldRecentsMenuItemTag;
        
        NSMenuItem *noRecentsMenuItem = [[NSMenuItem alloc] initWithTitle:@"No Recents" action:nullptr keyEquivalent:@""];
        noRecentsMenuItem.tag = NSSearchFieldNoRecentsMenuItemTag;
        
        NSMenuItem *clearMenuItem = [[NSMenuItem alloc] initWithTitle:@"Clear" action:nullptr keyEquivalent:@""];
        clearMenuItem.tag = NSSearchFieldClearRecentsMenuItemTag;
        clearMenuItem.image = [NSImage imageWithSystemSymbolName:@"trash" accessibilityDescription:nullptr];
        
        [searchMenu addItem:recentsTitleMenuItem];
        [searchMenu addItem:recentsMenuItem];
        [searchMenu addItem:noRecentsMenuItem];
        [searchMenu addItem:NSMenuItem.separatorItem];
        [searchMenu addItem:clearMenuItem];
        [recentsTitleMenuItem release];
        [recentsMenuItem release];
        [noRecentsMenuItem release];
        [clearMenuItem release];
        
        searchField.searchMenuTemplate = searchMenu;
        [searchMenu release];
        
        searchField.target = self;
        searchField.action = @selector(searchFieldFoo:);
        
        return [searchItem autorelease];
    } else if ([itemIdentifier isEqualToString:AppDelegateIdentifiers::menuToolbarItemIdentifier]) {
        MenuToolbarItem *toolbarItem = [[MenuToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
        toolbarItem.title = @"Palette";
        toolbarItem.image = [NSImage imageWithSystemSymbolName:@"paintpalette" accessibilityDescription:nullptr];
        
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Memu"];
        [menu addItemWithTitle:@"Test" action:nullptr keyEquivalent:@""];
        
        NSMenu *paletteMenu = [NSMenu paletteMenuWithColors:@[NSColor.systemRedColor, NSColor.systemOrangeColor, NSColor.systemYellowColor, NSColor.systemGreenColor, NSColor.systemBlueColor, NSColor.systemPurpleColor]
                                                     titles:@[]
                                           selectionHandler:^(NSMenu * _Nonnull menu) {
            
        }];
        
        [paletteMenu.itemArray enumerateObjectsUsingBlock:^(NSMenuItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@", obj);
        }];
        
        NSMenuItem *paletteMenuItem = [[NSMenuItem alloc] initWithTitle:@"Palette" action:nullptr keyEquivalent:@""];
        paletteMenuItem.submenu = paletteMenu;
        
        [menu addItem:paletteMenuItem];
        [paletteMenuItem release];
        
        toolbarItem.menu = menu;
        [menu release];
        
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
        AppDelegateIdentifiers::leftNavigationalItemIdentifier,
        AppDelegateIdentifiers::rightNavigationalItemIdentifier,
        AppDelegateIdentifiers::groupItemIdentifier,
        AppDelegateIdentifiers::showsBaselineSeparatorItemIdentifier,
        AppDelegateIdentifiers::toggleInspectorItemIdentifier,
        AppDelegateIdentifiers::runCustomizationPaletteItemIdentifier,
        AppDelegateIdentifiers::progressIndicatorItemIdentifier,
        AppDelegateIdentifiers::trackingSeparatorItemIdentifier,
        AppDelegateIdentifiers::popoverItemIdentifier,
        AppDelegateIdentifiers::menuToolbarItemIdentifier,
        NSToolbarSpaceItemIdentifier,
        NSToolbarCloudSharingItemIdentifier,
        NSToolbarPrintItemIdentifier,
        NSToolbarShowColorsItemIdentifier,
        NSToolbarShowFontsItemIdentifier,
        AppDelegateIdentifiers::searchItemIdentifier,
        NSToolbarInspectorTrackingSeparatorItemIdentifier,
        NSToolbarFlexibleSpaceItemIdentifier,
        NSToolbarToggleInspectorItemIdentifier
    ];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return [self toolbarAllowedItemIdentifiers:toolbar];
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

#pragma mark - NSSearchFieldDelegate

- (void)searchFieldDidStartSearching:(NSSearchField *)sender {
    NSLog(@"%@", sender.recentSearches);
}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender {
    
}

@end
