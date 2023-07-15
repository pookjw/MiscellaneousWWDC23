//
//  PresentViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/16/23.
//

#import "PresentViewController.hpp"
#import <objc/message.h>
#import <string>
#import <unordered_map>
#import <algorithm>

@interface PresentViewController ()
@property (assign) std::unordered_map<std::string, NSButton *> buttons;
@end

@implementation PresentViewController

- (void)dealloc {
    auto buttons = _buttons;
    std::for_each(buttons.cbegin(), buttons.cend(), [](const std::pair<std::string, NSButton *> pair) {
        [pair.second release];
    });
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.drawsBackground = NO;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scrollView];
    [NSLayoutConstraint activateConstraints:@[
        [scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    //
    
    NSStackView *stackView = [[NSStackView alloc] initWithFrame:scrollView.bounds];
    stackView.alignment = NSLayoutAttributeTop;
    stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
    scrollView.documentView = stackView;
    [scrollView release];
    
    //
    
    const std::unordered_map<std::string, NSButton *> buttons {
        {"test", nullptr}
    };
    self.buttons = buttons;
    
    //
    
    [stackView release];
}

@end
