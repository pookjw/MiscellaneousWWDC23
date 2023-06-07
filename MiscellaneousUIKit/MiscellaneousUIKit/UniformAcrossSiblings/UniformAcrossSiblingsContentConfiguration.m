//
//  UniformAcrossSiblingsContentConfiguration.m
//  MiscellaneousUIKit
//
//  Created by Jinwoo Kim on 6/8/23.
//

#import "UniformAcrossSiblingsContentConfiguration.h"
#import "UniformAcrossSiblingsContentView.h"

@interface UniformAcrossSiblingsContentConfiguration ()
@property (copy) NSString *imageName;
@end

@implementation UniformAcrossSiblingsContentConfiguration

- (instancetype)initWithImageName:(NSString *)imageName {
    if (self = [self init]) {
        self.imageName = imageName;
    }
    
    return self;
}

- (void)dealloc {
    [_imageName release];
    [super dealloc];
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone { 
    UniformAcrossSiblingsContentConfiguration *copy = [self.class new];
    
    if (copy) {
        copy.imageName = self.imageName;
    }
    
    return copy;
}

- (nonnull __kindof UIView<UIContentView> *)makeContentView { 
    return [[[UniformAcrossSiblingsContentView alloc] initWithConfiguration:self] autorelease];
}

- (nonnull instancetype)updatedConfigurationForState:(nonnull id<UIConfigurationState>)state { 
    return self;
}

@end
