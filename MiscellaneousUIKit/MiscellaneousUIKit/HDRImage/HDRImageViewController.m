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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.preferredImageDynamicRange = UIImageDynamicRangeHigh;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    
    NSURL *url = [NSBundle.mainBundle URLForResource:@"image" withExtension:@"dng"];
    CIImage *ciImage = [[CIImage alloc] initWithContentsOfURL:url options:@{kCIImageExpandToHDR: @YES}];
    
    // Not recommended
    CIContext *context = [CIContext new];
    CGImageRef cgImage = [context createCGImage:ciImage fromRect:ciImage.extent];
    UIImage *image = [[UIImage alloc] initWithCGImage:cgImage];
//    CIRAWFilter *rawFilter = [CIRAWFilter filterWithImageURL:url];
//    rawFilter.extendedDynamicRangeAmount = 2.f;
//    UIImage *image = [[UIImage alloc] initWithCIImage:ciImage];
    NSLog(@"%d", image.isHighDynamicRange);
    [ciImage release];
    imageView.image = image;
    [image release];
    
    imageView.image = image;
    [imageView release];
//    UIImageReaderConfiguration *configuration = [UIImageReaderConfiguration new];
//    configuration.prefersHighDynamicRange = YES;
//    configuration.preparesImagesForDisplay = NO;
//    
//    [[UIImageReader readerWithConfiguration:configuration] imageWithContentsOfFileURL:url completion:^(UIImage * _Nullable image) {
//        [NSOperationQueue.mainQueue addOperationWithBlock:^{
//            self.imageView = imageView;
//            [imageView release];
//        }];
//    }];
//    
//    [configuration release];
}

@end
