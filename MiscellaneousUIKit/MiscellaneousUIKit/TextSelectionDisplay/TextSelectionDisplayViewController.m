//
//  TextSelectionDisplayViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/19/23.
//

#import "TextSelectionDisplayViewController.h"

@interface TextSelectionDisplayCursorView : UIView <UITextCursorView>
@end

@implementation TextSelectionDisplayCursorView {
    BOOL _isBlinking;
}

- (BOOL)isBlinking {
    return _isBlinking;
}

- (void)setBlinking:(BOOL)blinking {
    _isBlinking = blinking;
}

- (void)resetBlinkAnimation {
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}

@end

@interface TextSelectionDisPlayHighlightView : UIView <UITextSelectionHighlightView>
@end

@implementation TextSelectionDisPlayHighlightView

- (NSArray<UITextSelectionRect *> *)selectionRects {
    return @[];
}

- (void)setSelectionRects:(NSArray<UITextSelectionRect *> *)selectionRects {
    
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
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
    
    UITextSelectionDisplayInteraction *interaction = [[UITextSelectionDisplayInteraction alloc] initWithTextInput:textView delegate:self];
    TextSelectionDisplayCursorView *cursorView = [TextSelectionDisplayCursorView new];
    interaction.cursorView = cursorView;
    [cursorView release];
    
    TextSelectionDisPlayHighlightView *highlightView = [TextSelectionDisPlayHighlightView new];
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
