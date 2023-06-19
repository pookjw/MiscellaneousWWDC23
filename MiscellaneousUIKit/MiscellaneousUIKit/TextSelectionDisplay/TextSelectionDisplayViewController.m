//
//  TextSelectionDisplayViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/19/23.
//

#import "TextSelectionDisplayViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import "NSObject+Foundation_IvarDescription.h"

@interface TextSelectionDisplayCursorView : UIView <UITextCursorView>
@end

@implementation TextSelectionDisplayCursorView {
    BOOL _isBlinking;
}

+ (void)load {
    class_addProtocol(TextSelectionDisplayCursorView.class, NSProtocolFromString(@"_UITextSelectionWidgetAnimating"));
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.layer.backgroundColor = UIColor.purpleColor.CGColor;
        [self startAnimation];
    }
    
    return self;
}

- (BOOL)isBlinking {
    return _isBlinking;
}

- (void)setBlinking:(BOOL)blinking {
    _isBlinking = blinking;
    
    if (blinking) {
        [self startAnimation];
    }
}

- (void)resetBlinkAnimation {
    [self startAnimation];
}

- (void)startAnimation {
    [self stopAnimation];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @0.f;
    animation.toValue = @1.f;
    animation.duration = 1.f;
    animation.repeatCount = HUGE_VALF;
    
    [self.layer addAnimation:animation forKey:@"blink"];
}

- (void)stopAnimation {
    [self.layer removeAnimationForKey:@"blink"];
}

#pragma mark - _UITextSelectionWidgetAnimating

- (BOOL)hiddenForLoupeAnimation {
    return NO;
}

- (CGSize)originShadow {
    return CGSizeZero;
}

- (CGRect)originShape {
    return CGRectZero;;
}

- (void)setHiddenForLoupeAnimation:(BOOL)arg1 {
    
}

@end

@interface TextSelectionDisplayHighlightView : UIView <UITextSelectionHighlightView>
@end

@implementation TextSelectionDisplayHighlightView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}


- (NSArray<UITextSelectionRect *> *)selectionRects {
    return @[];
}

- (void)setSelectionRects:(NSArray<UITextSelectionRect *> *)selectionRects {
    
}

@end

@interface TextSelectionDisplayViewController () <UITextSelectionDisplayInteractionDelegate>
@property (retain) UITextView *textView;
@end

@implementation TextSelectionDisplayViewController

- (void)dealloc {
    [_textView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [textView.interactions enumerateObjectsUsingBlock:^(id<UIInteraction>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:UITextSelectionDisplayInteraction.class]) {
            [textView removeInteraction:obj];
            *stop = YES;
//            UITextSelectionDisplayInteraction *interaction = (UITextSelectionDisplayInteraction *)obj;
//            ((void (*)(id, SEL, BOOL))objc_msgSend)(interaction.cursorView, NSSelectorFromString(@"setGlowEffectEnabled:"), YES);
        }
    }];
    
    UITextSelectionDisplayInteraction *interaction = [[UITextSelectionDisplayInteraction alloc] initWithTextInput:textView delegate:self];
    TextSelectionDisplayCursorView *cursorView = [TextSelectionDisplayCursorView new];
    interaction.cursorView = cursorView;
    [cursorView release];
    
    TextSelectionDisplayHighlightView *highlightView = [TextSelectionDisplayHighlightView new];
    interaction.highlightView = highlightView;
    [highlightView release];
    
    [textView addInteraction:interaction];
    
    interaction.activated = YES;
    [interaction release];
    
    [self.view addSubview:textView];
    [NSLayoutConstraint activateConstraints:@[
        [textView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    self.textView = textView;
    [textView release];
}

//- (UIView *)selectionContainerViewBelowTextForSelectionDisplayInteraction:(UITextSelectionDisplayInteraction *)interaction {
//    return self.textView;
//}

@end
