//
//  UniformAcrossSiblingsContentView.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import "UniformAcrossSiblingsContentView.h"

@interface UniformAcrossSiblingsContentView ()
@property (copy) UniformAcrossSiblingsContentConfiguration *ownConfiguration;
@property (retain) UIImageView *imageView;
@end

@implementation UniformAcrossSiblingsContentView

- (instancetype)initWithConfiguration:(UniformAcrossSiblingsContentConfiguration *)configuration {
    if (self = [self init]) {
        self.configuration = configuration;
        
        UIImageView *imageView = [UIImageView new];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        [NSLayoutConstraint activateConstraints:@[
            [imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
        ]];
        self.imageView = imageView;
        [imageView release];
    }
    
    return self;
}

- (void)dealloc {
    [_ownConfiguration release];
    [super dealloc];
}

- (id<UIContentConfiguration>)configuration {
    return self.ownConfiguration;
}

- (void)setConfiguration:(id<UIContentConfiguration>)configuration {
    self.ownConfiguration = configuration;
    self.imageView.image = [UIImage imageNamed:self.ownConfiguration.imageName];
}

- (BOOL)supportsConfiguration:(id<UIContentConfiguration>)configuration {
    return [configuration isKindOfClass:UniformAcrossSiblingsContentConfiguration.class];
}

@end
