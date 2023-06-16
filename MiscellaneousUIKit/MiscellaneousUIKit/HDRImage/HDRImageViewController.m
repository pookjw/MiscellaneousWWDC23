//
//  HDRImageViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/17/23.
//

#import "HDRImageViewController.h"

@interface HDRImageViewController ()
@property (retain) UIImageView *imageView;
@end

@implementation HDRImageViewController

- (void)dealloc {
    [_imageView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
}

@end
