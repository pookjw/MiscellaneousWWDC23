//
//  PageControlViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import "PageControlViewController.h"
#import <objc/message.h>

@interface PageControlViewController () <UIPageControlProgressDelegate, UIPageControlTimerProgressDelegate>
@property (retain) UIPageControl *pageControl;
@end

@implementation PageControlViewController

- (void)dealloc {
    [_pageControl release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UIPageControl *pageControl = [UIPageControl new];
    pageControl.numberOfPages = 5;
    pageControl.currentPageIndicatorTintColor = UIColor.systemPurpleColor;
    pageControl.pageIndicatorTintColor = UIColor.systemPurpleColor;
    
//    UIPageControlProgress *progess = [UIPageControlProgress new];
//    progess.delegate = self;
//    pageControl.progress = progess;
//    [progess release];
    
    // customDurationByPage
    UIPageControlTimerProgress *timerProgess = [[UIPageControlTimerProgress alloc] initWithPreferredDuration:1.f];
    timerProgess.preferredDuration = 1.f;
//    timerProgess.delegate = self;
    pageControl.progress = timerProgess;
    
    ((void (*)(id, SEL, BOOL))objc_msgSend)(timerProgess, NSSelectorFromString(@"setEnableTimer:"), YES);
    ((void (*)(id, SEL))objc_msgSend)(timerProgess, NSSelectorFromString(@"_updateTimer"));
//    [timerProgess pauseTimer];
    if (!timerProgess.isRunning) {
        [timerProgess resumeTimer];
        NSLog(@"%d", timerProgess.isRunning);
    }
    [timerProgess release];
    
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pageControl];
    [NSLayoutConstraint activateConstraints:@[
        [pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [pageControl.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
    self.pageControl = pageControl;
    [pageControl release];
}

//- (float)pageControlProgress:(UIPageControlProgress *)progress initialProgressForPage:(NSInteger)page {
//    return 0.2f;
//}
//
//- (void)pageControlProgressVisibilityDidChange:(UIPageControlProgress *)progress {
//    NSLog(@"%@", progress);
//}

//- (BOOL)pageControlTimerProgress:(UIPageControlTimerProgress *)progress shouldAdvanceToPage:(NSInteger)page {
//    return YES;
//}
//
//- (void)pageControlTimerProgressDidChange:(UIPageControlTimerProgress *)progress {
//    NSLog(@"%@", progress);
//}

@end
