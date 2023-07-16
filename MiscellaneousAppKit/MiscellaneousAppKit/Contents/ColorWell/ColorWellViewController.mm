//
//  ColorWellViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/15/23.
//

#import "ColorWellViewController.hpp"
#import <objc/message.h>
#import <memory>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@interface ColorWell : NSColorWell
@property (retain) NSColorList *colorList;
@end

@implementation ColorWell

- (void)dealloc {
    [_colorList release];
    [super dealloc];
}

- (void)activate:(BOOL)exclusive {
    [super activate:exclusive];
    
    NSLog(@"%@", NSColorList.availableColorLists);
    
    NSColorListName colorListName = @"MiscellaneousColorList";
    NSColorList *colorList = [[NSColorList alloc] initWithName:colorListName];
    
    NSColorName systemOrangeName = @"System Orange";
    [colorList setColor:NSColor.systemOrangeColor forKey:systemOrangeName];
    
    [NSColorPanel.sharedColorPanel attachColorList:colorList];
    
    self.colorList = colorList;
    [colorList release];
}

- (void)deactivate {
    NSError * _Nullable error = nullptr;
    
    NSURL *url = [[[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject URLByAppendingPathComponent:@"test"] URLByAppendingPathExtension:@"clr"];
    
    if ([NSFileManager.defaultManager fileExistsAtPath:url.path]) {
        [NSFileManager.defaultManager removeItemAtURL:url error:&error];
        NSAssert(error == nullptr, error.localizedDescription);
    }
    
    [self.colorList writeToURL:url error:&error];
    NSAssert(error == nullptr, error.localizedDescription);
    
    self.colorList = nil;
    [super deactivate];
}

- (void)_performActivationClickWithShiftDown:(BOOL)arg1 {
    NSPopover *presentingPopover = reinterpret_cast<NSPopover * (*)(NSColorWell *, SEL)>(objc_msgSend)(self, NSSelectorFromString(@"presentedPopover"));
    
    if (presentingPopover) {
        [presentingPopover close];
    } else {
        struct objc_super superInfo = { self, self.superclass };
        reinterpret_cast<void (*)(struct objc_super *, SEL, BOOL)>(objc_msgSendSuper)(&superInfo, @selector(_performActivationClickWithShiftDown:), arg1);
        
        NSPopover *popover = reinterpret_cast<NSPopover * (*)(NSColorWell *, SEL)>(objc_msgSend)(self, NSSelectorFromString(@"presentedPopover"));
        if (popover) {
            popover.behavior = NSPopoverBehaviorApplicationDefined;
        }
    }
}

@end

@interface ColorWellViewController ()
@property (retain) ColorWell *colorWell;
@property (assign) std::shared_ptr<std::uint8_t> context;
@end

@implementation ColorWellViewController

- (void)dealloc {
    [_colorWell removeObserver:self forKeyPath:@"color" context:_context.get()];
    [_colorWell release];
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == self.context.get()) {
        self.view.layer.backgroundColor = reinterpret_cast<NSColor *>(change[NSKeyValueChangeNewKey]).CGColor;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.wantsLayer = YES;
    self.context = std::make_shared<std::uint8_t>();
    
    ColorWell *colorWell = [ColorWell new];
    colorWell.colorWellStyle = NSColorWellStyleExpanded;
    
    colorWell.translatesAutoresizingMaskIntoConstraints = NO;
    colorWell.supportsAlpha = YES;
    [colorWell takeColorFrom:self];
    
    [colorWell addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:self.context.get()];
    
    [self.view addSubview:colorWell];
    [NSLayoutConstraint activateConstraints:@[
        [colorWell.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [colorWell.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    
    self.colorWell = colorWell;
    [colorWell release];
}

- (NSColor *)color {
    return NSColor.systemPurpleColor;
}

@end
