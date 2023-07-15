//
//  DisplayLinkViewController.mm
//  MiscellaneousAppKit
//
//  Created by Jinwoo Kim on 7/15/23.
//

#import "DisplayLinkViewController.hpp"
#import <QuartzCore/QuartzCore.h>

@interface DisplayLinkViewController ()
@property (retain) CADisplayLink *displayLink;
@end

@implementation DisplayLinkViewController

- (void)dealloc {
    [_displayLink invalidate];
    [_displayLink release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CADisplayLink *displayLink = [self.view displayLinkWithTarget:self selector:@selector(foo:)];
    [displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    self.displayLink = displayLink;
}

- (void)foo:(CADisplayLink *)sender {
    NSLog(@"%@", sender);
}

@end
