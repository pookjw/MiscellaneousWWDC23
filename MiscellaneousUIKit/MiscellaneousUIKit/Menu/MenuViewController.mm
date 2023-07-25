//
//  MenuViewController.mm
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 7/25/23.
//

#import "MenuViewController.h"
#import "SymbolButtonConfiguration.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <vector>
#import <string>
#import <algorithm>
#import <ranges>

namespace _UIContextMenuListView {
    namespace _configureCell_forElement_section_size {
        std::uint8_t *associationKey = nullptr;
        
        void (*original)(id, SEL, __kindof UICollectionViewCell *, __kindof UIMenuElement *, id, NSUInteger);
        void custom(id self, SEL _cmd, __kindof UICollectionViewCell *cell, __kindof UIMenuElement *element, id section, NSUInteger size) {
            original(self, _cmd, cell, element, section, size);
            
            auto symbolEffect = static_cast<__kindof NSSymbolEffect * _Nullable>(objc_getAssociatedObject(element, associationKey));
            if (!symbolEffect) return;
            
            // _UIContextMenuCellContentView
            __kindof UIView *contentView = cell.contentView;
            
            auto imageViews = std::vector<std::string> {
                "decorationImageView",
                "iconImageView",
                "emphasizediconImageView"
            } |
            std::views::transform([contentView](const std::string name) {
                return reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(contentView, sel_registerName(name.data()));
            });
            
            std::for_each(imageViews.begin(), imageViews.end(), [symbolEffect](UIImageView * _Nullable imageView) {
                if (!imageView) return;
                
                NSAutoreleasePool *pool = [NSAutoreleasePool new];
                
                [imageView addSymbolEffect:symbolEffect
                                   options:[NSSymbolEffectOptions optionsWithRepeating]
                                  animated:YES];
                
                [pool release];
            });
        }
    }
}

namespace _UIAction {
    namespace copyWithZone {
        id (*original)(id, SEL, struct _NSZone *);
        id custom(id self, SEL _cmd, struct _NSZone *zone) {
            id copy = original(self, _cmd, zone);
            
            id object = objc_getAssociatedObject(self, _UIContextMenuListView::_configureCell_forElement_section_size::associationKey);
            objc_setAssociatedObject(copy,
                                     _UIContextMenuListView::_configureCell_forElement_section_size::associationKey,
                                     object,
                                     OBJC_ASSOCIATION_COPY);
            
            return copy;
        }
    }
    
    namespace _immutableCopy {
        id (*original)(id, SEL);
        id custom(id self, SEL _cmd) {
            id copy = original(self, _cmd);
            
            id object = objc_getAssociatedObject(self, _UIContextMenuListView::_configureCell_forElement_section_size::associationKey);
            objc_setAssociatedObject(copy,
                                     _UIContextMenuListView::_configureCell_forElement_section_size::associationKey,
                                     object,
                                     OBJC_ASSOCIATION_COPY);
            
            return copy;
        }
    }
}

@interface MenuViewController ()
@property (retain) UIButton *button;
@property (retain) UITextField *textField;
@end

@implementation MenuViewController

+ (void)load {
    _UIContextMenuListView::_configureCell_forElement_section_size::associationKey = new std::uint8_t;
    
    Method method_1 = class_getInstanceMethod(NSClassFromString(@"_UIContextMenuListView"), NSSelectorFromString(@"_configureCell:forElement:section:size:"));
    _UIContextMenuListView::_configureCell_forElement_section_size::original = reinterpret_cast<void (*)(id, SEL, __kindof UICollectionViewCell *, __kindof UIMenuElement *, id, NSUInteger)>(method_getImplementation(method_1));
    method_setImplementation(method_1, reinterpret_cast<IMP>(_UIContextMenuListView::_configureCell_forElement_section_size::custom));
    
    //
    
    Method method_2 = class_getInstanceMethod(UIAction.class, @selector(copyWithZone:));
    _UIAction::copyWithZone::original = reinterpret_cast<id (*)(id, SEL, struct _NSZone *)>(method_getImplementation(method_2));
    method_setImplementation(method_2, reinterpret_cast<IMP>(_UIAction::copyWithZone::custom));
    
    //
 
    Method method_3 = class_getInstanceMethod(UIAction.class, NSSelectorFromString(@"_immutableCopy"));
    _UIAction::_immutableCopy::original = reinterpret_cast<id (*)(id, SEL)>(method_getImplementation(method_3));
    method_setImplementation(method_3, reinterpret_cast<IMP>(_UIAction::_immutableCopy::custom));
}

- (void)dealloc {
    [_button release];
    [_textField release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UITextField *textField = [UITextField new];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.text = @"Test";
    
    UIAction *action = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
    }];
    
    SymbolButtonConfiguration *configuration = [SymbolButtonConfiguration plainButtonConfiguration];
    configuration.image = [UIImage systemImageNamed:@"filemenu.and.selection"];
    
    SymbolButtonConfigurationEffect *effect = [[SymbolButtonConfigurationEffect alloc] initWithSymbolEffect:[[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer]
                                                                                                    options:[NSSymbolEffectOptions optionsWithRepeating]
                                                                                                   animated:YES
                                                                                                 completion:nil];
    [configuration.sbc_effects addObject:effect];
    [effect release];
    
    UIButton *button = [UIButton new];
    button.configuration = configuration;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    //
    
    UIImageConfiguration *redImageConfiguration = [UIImageSymbolConfiguration configurationWithPaletteColors:@[UIColor.systemRedColor]];
    UIImageConfiguration *blueImageConfiguration = [UIImageSymbolConfiguration configurationWithPaletteColors:@[UIColor.systemBlueColor]];
    UIImageConfiguration *greenImageConfiguration = [UIImageSymbolConfiguration configurationWithPaletteColors:@[UIColor.systemGreenColor]];
    
    UIAction *arrowAction = [UIAction actionWithTitle:@"Arrow" image:[UIImage systemImageNamed:@"arrowshape.forward.fill" withConfiguration:greenImageConfiguration] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }];
    // Not available in Objective-C?
    ((void (*)(id, SEL, id))objc_msgSend)(arrowAction, NSSelectorFromString(@"setSelectedImage:"), [UIImage systemImageNamed:@"arrowshape.forward.circle" withConfiguration:greenImageConfiguration]);
    
    UIMenu *paletteMenu = [UIMenu menuWithTitle:@"Palette"
                                          image:[UIImage systemImageNamed:@"paintpalette"]
                                     identifier:nil
                                        options:UIMenuOptionsDisplayInline | UIMenuOptionsSingleSelection | UIMenuOptionsDisplayAsPalette
                                       children:@[
        [UIAction actionWithTitle:@"Red" image:[UIImage systemImageNamed:@"archivebox.fill" withConfiguration:redImageConfiguration] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }],
        [UIAction actionWithTitle:@"Circle" image:[UIImage systemImageNamed:@"circle.hexagongrid"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }],
        [UIAction actionWithTitle:@"Clipboard" image:[UIImage systemImageNamed:@"arrow.right.doc.on.clipboard" withConfiguration:blueImageConfiguration] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
    }],
        arrowAction
    ]];
    
    [paletteMenu.children enumerateObjectsUsingBlock:^(UIMenuElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        objc_setAssociatedObject(obj,
                                 _UIContextMenuListView::_configureCell_forElement_section_size::associationKey,
                                 [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer],
                                 OBJC_ASSOCIATION_COPY);
    }];
    
    paletteMenu.preferredElementSize = UIMenuElementSizeLarge;
    
    UIMenu *menu = [UIMenu menuWithTitle:@"Menu"
                                   image:[UIImage systemImageNamed:@"filemenu.and.selection"]
                              identifier:nil
                                 options:UIMenuOptionsDisplayInline
                                children:@[
        paletteMenu,
        [UIAction captureTextFromCameraActionForResponder:textField identifier:nil],
    ]];
    
    [menu.children enumerateObjectsUsingBlock:^(UIMenuElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:UIAction.class]) return;
        
        objc_setAssociatedObject(obj,
                                 _UIContextMenuListView::_configureCell_forElement_section_size::associationKey,
                                 [[NSSymbolBounceEffect bounceUpEffect] effectWithByLayer],
                                 OBJC_ASSOCIATION_COPY);
        
        ((UIAction *)obj).attributes = UIMenuElementAttributesKeepsMenuPresented;
    }];
    
    button.menu = menu;
    button.showsMenuAsPrimaryAction = YES;
    
    //
    
    [self.view addSubview:textField];
    [self.view addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [textField.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
        [textField.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor],
        [textField.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor],
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    self.button = button;
    self.textField = textField;
    [button release];
    [textField release];
}

@end
