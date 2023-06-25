//
//  LocaleImageViewController.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/26/23.
//

#import "LocaleImageViewController.h"
#import <objc/message.h>

@interface LocaleImageViewController ()

@end

@implementation LocaleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSString *> *_availableLocaleIdentifiers = ((NSArray * (*)(Class, SEL))objc_msgSend)(NSLocale.class, NSSelectorFromString(@"_availableLocaleIdentifiers"));
    NSArray *sorted = [_availableLocaleIdentifiers sortedArrayUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    [sorted enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", obj);
    }];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    UIImageConfiguration *configuration = [UIImageSymbolConfiguration configurationWithLocale:[NSLocale localeWithLocaleIdentifier:@"ko_KR"]];
    UIImage *image = [UIImage systemImageNamed:@"character.book.closed.fill" withConfiguration:configuration];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    [NSLayoutConstraint activateConstraints:@[
        [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
    [imageView release];
}

@end
