//
//  SymbolEffectsViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/18/23.
//

#import "SymbolEffectsViewController.h"
#import <Symbols/Symbols.h>
#import <objc/message.h>

@interface SymbolEffectsViewController ()
@property (retain) UIImageView *imageView;
@end

@implementation SymbolEffectsViewController

- (void)dealloc {
    [_imageView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
//    UIImage *image = [UIImage systemImageNamed:@"square.and.at.rectangle.fill" withConfiguration:nil];
    UIImage *cellularbarsImage = [UIImage systemImageNamed:@"cellularbars" withConfiguration:nil];
    
    NSArray *_availableLocaleIdentifiers = ((NSArray * (*)(id, SEL))objc_msgSend)(NSLocale.class, NSSelectorFromString(@"_availableLocaleIdentifiers"));
    NSLog(@"%@", _availableLocaleIdentifiers);
//    UIImageSymbolConfiguration *configuration = [UIImageSymbolConfiguration configurationWithLocale:[NSLocale loca]]
//    UIImage *characterImage = [UIImage systemImageNamed:@"character.textbox" withConfiguration:<#(nullable UIImageConfiguration *)#>]
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cellularbarsImage];
    
//    CALayer *_rbSymbolLayer = ((CALayer * (*)(id, SEL))objc_msgSend)(imageView, NSSelectorFromString(@"_rbSymbolLayer"));
//    id animator = ((id (*)(id, SEL))objc_msgSend)(_rbSymbolLayer, NSSelectorFromString(@"animator"));
//    NSDictionary *dic = @{
//        @"bounceOptions": @2,
//        @"byLayer": @YES,
//        @"repeatCount": @3,
//        @"speed": @0.5f
//    };
//    ((NSUInteger (*)(id, SEL, NSUInteger, NSDictionary *))objc_msgSend)(animator, NSSelectorFromString(@"addAnimation:options:"), 3, dic);
    
    // 1: up, 2: down
//    NSSymbolBounceEffect *effect = [[[NSSymbolBounceEffect effect] effectWithByLayer] _withDirection:2];
    NSSymbolVariableColorEffect *effect = [[[[NSSymbolVariableColorEffect effect] effectWithIterative] effectWithDimInactiveLayers] effectWithReversing];
    NSSymbolEffectOptions *options = [[NSSymbolEffectOptions optionsWithRepeating] optionsWithSpeed:0.1f];
    
    [imageView addSymbolEffect:effect options:options animated:YES completion:^(UISymbolEffectCompletionContext * _Nonnull context) {
        
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [imageView removeSymbolEffectOfType:effect options:options animated:YES];
//    });
    
    imageView.tintColor = UIColor.systemPinkColor;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
    
    self.imageView = imageView;
    [imageView release];
    
    //
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"cellularbars" withConfiguration:nil] menu:nil];
    [item addSymbolEffect:effect options:options animated:YES];
    item.symbolAnimationEnabled = YES;
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}

@end
