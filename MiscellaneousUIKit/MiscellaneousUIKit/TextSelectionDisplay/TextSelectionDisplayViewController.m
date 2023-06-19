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

@interface TextSelectionDisplayInteraction : UITextSelectionDisplayInteraction
@end

@implementation TextSelectionDisplayInteraction

//- (UIView *)_highlightView {
//    return self.highlightView;
//}
//
//- (UIView *)_underlineView {
//    return self.highlightView;
//}

@end

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
        self.backgroundColor = [UIColor.purpleColor colorWithAlphaComponent:0.3f];
    }
    
    return self;
}


- (NSArray<UITextSelectionRect *> *)selectionRects {
    return @[];
}

- (void)setSelectionRects:(NSArray<UITextSelectionRect *> *)selectionRects {
    NSLog(@"%@", selectionRects);
}

@end

@interface TextSelectionDisplayViewController () <UITextSelectionDisplayInteractionDelegate>
@property (retain) UITextView *textView;
@property (retain) TextSelectionDisplayInteraction *interaction;
@end

@implementation TextSelectionDisplayViewController

// UITextInteractionAssistant

- (void)dealloc {
    [_textView release];
    [_interaction release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@", [NSObject _fd__protocolDescriptionForProtocol:NSProtocolFromString(@"UITextSelectionDisplayInteractionDelegate_Internal")]);
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.delegate = self;
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *toBeRemoved = [NSMutableArray new];
    [textView.interactions enumerateObjectsUsingBlock:^(id<UIInteraction>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:UITextSelectionDisplayInteraction.class]) {
            [toBeRemoved addObject:obj];
//            UITextSelectionDisplayInteraction *interaction = (UITextSelectionDisplayInteraction *)obj;
            // UITextInteractionAssistant
//            NSLog(@"%@", [interaction.delegate selectionContainerViewBelowTextForSelectionDisplayInteraction:interaction]);
//            ((void (*)(id, SEL, BOOL))objc_msgSend)(interaction.cursorView, NSSelectorFromString(@"setGlowEffectEnabled:"), YES);
        } else if ([obj isKindOfClass:NSClassFromString(@"UITextSelectionInteraction")]) {
//            [toBeRemoved addObject:obj];
        }
    }];
    
    [toBeRemoved enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [textView removeInteraction:obj];
    }];
    [toBeRemoved release];
    
    id<UITextSelectionDisplayInteractionDelegate> interactionAssistant = ((id (*)(id, SEL))objc_msgSend)(textView, NSSelectorFromString(@"interactionAssistant"));
    TextSelectionDisplayInteraction *interaction = [[TextSelectionDisplayInteraction alloc] initWithTextInput:textView delegate:interactionAssistant];
    TextSelectionDisplayCursorView *cursorView = [TextSelectionDisplayCursorView new];
    interaction.cursorView = cursorView;
    [cursorView release];
    
    TextSelectionDisplayHighlightView *highlightView = [TextSelectionDisplayHighlightView new];
    interaction.highlightView = highlightView;
    NSLog(@"%@", [interaction view]);
    [highlightView release];
    
    NSLog(@"%@", interaction.handleViews);
    
    [textView addInteraction:interaction];
    
    self.interaction = interaction;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
    self.interaction.activated = YES;
}

//- (UIView *)selectionContainerViewBelowTextForSelectionDisplayInteraction:(UITextSelectionDisplayInteraction *)interaction {
//    return ((UIView * (*)(id, SEL))objc_msgSend)(interaction.textInput, NSSelectorFromString(@"selectionContainerView"));
//}

@end
